//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation

public typealias BackgroundCompletionHandler = (() -> Void)

public class URLBackgroundSessionNetworkManager : NSObject, BackgroundNetworkManager {

    public enum Error : Swift.Error {
        case unableToBuildURL
    }

    public  enum TimeoutPolicy {
        case short
        case long
    }
    
    private static var handlers : [String : BackgroundCompletionHandler] = [:]

    private static var handlersQueue = DispatchQueue(label: "meli.assessment.meli-sdk.backgroundHandlers")
    
    public var environment: NetworkEnvironment
    
    public var session : URLSession!
    
    public weak var delegate : BackgroundNetworkManagerDelegate?
    
    private var dataBuffers: [Int: Data] = [:]
    
    public init(backgroundId: String, environment: NetworkEnvironment, timeoutPolicy: TimeoutPolicy /*, keychain: KeychainManager = MemoryKeychainManager()*/) {
        
        self.environment = environment
        
        super.init()
        
        let config = URLSessionConfiguration.background(withIdentifier: backgroundId)
        config.sessionSendsLaunchEvents = true
        switch timeoutPolicy {
        case .short:
            config.timeoutIntervalForRequest = 60 * 5
            config.timeoutIntervalForResource = 60 * 60 * 2         // 2 hours
        case .long:
            config.timeoutIntervalForRequest = 60 * 5
            config.timeoutIntervalForResource = 60 * 60 * 24 * 2    // 2 days
        }

        self.session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }
    
    public static func setCompletionHandler(id: String, _ completion: @escaping BackgroundCompletionHandler) {
        handlersQueue.sync {
            URLBackgroundSessionNetworkManager.handlers[id] = completion
        }
        
    }
    
    public static func clearCompletionHandler(id: String) {
        handlersQueue.sync {
            URLBackgroundSessionNetworkManager.handlers[id] = nil
        }
        
    }
    
    private static func completionHandler(id: String) -> BackgroundCompletionHandler? {
        return handlersQueue.sync {
            return URLBackgroundSessionNetworkManager.handlers[id]
        }
        
    }
    
    public func download(endpoint: Endpoint) throws -> NetworkManagerSessionTask  {
        
        guard let request = try? urlRequest(forEndpoint: endpoint) else {
            throw Error.unableToBuildURL
        }
        
        let task = session.downloadTask(with: request)

        return task
    }
    
    public func upload(fileURL: URL, endpoint: Endpoint, allowsCellularAccess: Bool) throws -> NetworkManagerSessionTask {
        guard var request = try? urlRequest(forEndpoint: endpoint) else {
            throw Error.unableToBuildURL
        }

        request.allowsCellularAccess = allowsCellularAccess

        let task = session.uploadTask(with: request, fromFile: fileURL)
        
        return task
    }
    
    public func cancel(networkManagerSessionTaskIdentifiers: [Int], completionHandler: @escaping () -> Void) {
        session.getTasksWithCompletionHandler { (_, uploadTasks, _) in

            let idSet = Set(networkManagerSessionTaskIdentifiers)
            
            let toCancelTasks = uploadTasks.filter({ (task) -> Bool in
                return idSet.contains(task.identifier)
            })
            
            toCancelTasks.forEach({ (task) in
                task.cancel()
            })
            
            completionHandler()
        }
    }
    
    public func isUploading(networkManagerSessionTaskIdentifiers: [Int], completionHandler: @escaping (Bool) -> Void) {
        session.getTasksWithCompletionHandler { (_, uploadTasks, _) in

            print("Current tasks in session \(self.session.configuration.identifier!): \(uploadTasks.count)")

            let filteredTasks = uploadTasks.filter { $0.state == .running }
            
            let taskIdentifiers = filteredTasks.map { $0.taskIdentifier }
            
            let set1 = Set(networkManagerSessionTaskIdentifiers)
            let set2 = Set(taskIdentifiers)
            
            let intersection = set1.intersection(set2)
            
            let isUploading = !intersection.isEmpty
            
            completionHandler(isUploading)
        }
    }
    
    private func urlRequest(forEndpoint endpoint: Endpoint) throws -> URLRequest {
        var request = URLRequest(endpoint: endpoint)
        request.cachePolicy = environment.cachePolicy
        environment.headers.forEach { (key: String, value: String) in
            if (request.value(forHTTPHeaderField: key) == nil) {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
}

extension URLBackgroundSessionNetworkManager : URLSessionDataDelegate {
    
    public func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        
        guard let sessionId = session.configuration.identifier else {
            return
        }
        
        guard let completionHandler = URLBackgroundSessionNetworkManager.completionHandler(id: sessionId) else {
            return
        }
        
        DispatchQueue.main.async {
            completionHandler()
            URLBackgroundSessionNetworkManager.clearCompletionHandler(id: sessionId)
        }
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Swift.Error?) {

        print("DID Complete task \(task.identifier)")

        if let error = error {
            print("DID Complete task \(task.identifier) with error: \(error)")
            self.delegate?.didFail(task: task, with: NetworkError.unknown)
            return
        }
        
        guard let response = task.response as? HTTPURLResponse else {
            self.delegate?.didFail(task: task, with: NetworkError.unknown)
            return
        }
        
        print("DID Complete task \(task.identifier) with response: \(response)")
            
        if let serverError = parseError(response: response) {
            self.delegate?.didFail(task: task, with: serverError)
            return
        }
        
        //*TEST*//
        if let data = self.dataBuffers[task.taskIdentifier] {
            if let string = String(data: data, encoding: .utf8) {
                print("TEST DOWNLOAD DELEGATE END: Download: >>>>>> " + string)
            } else {
                print("TEST DOWNLOAD  DELEGATE END: Failed to parse downloaded data")
            }
            self.dataBuffers[task.taskIdentifier] = nil
        }


        self.delegate?.didComplete(task: task)
    }
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        
        var dataBuffer = self.dataBuffers[dataTask.taskIdentifier]
        dataBuffer?.append(data)
        
        if let string = String(data: data, encoding: .utf8) {
            print("TEST DOWNLOAD DELEGATE: Download: >>>>>> " + string)
        } else {
            print("TEST DOWNLOAD DELEGATE: Failed to parse downloaded data")
        }

    }
    
    private func parseError(response: HTTPURLResponse) -> NetworkError? {
        switch response.statusCode {
        case 200...299:
            return nil
        case 400:
            return .badRequest
        case 401:
            return .unauthorized
        case 403:
            return .forbidden
        case 404:
            return .notFound
        case 405...499:
            return .clientFault
        case 500...599:
            return .serverFault
        default:
            return .unknown
        }
    }
    
}

extension URLBackgroundSessionNetworkManager : URLSessionDownloadDelegate {
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        do {
            let data = try Data(contentsOf: location)
            self.delegate?.didCompleteDownload(task: downloadTask, data: data)
        } catch {
            self.delegate?.didFail(task: downloadTask, with: .parseData)
        }
    }
}
