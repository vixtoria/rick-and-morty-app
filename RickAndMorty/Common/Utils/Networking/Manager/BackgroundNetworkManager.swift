//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation

public protocol BackgroundNetworkManager {
    
    static func setCompletionHandler(id: String, _ completion: @escaping BackgroundCompletionHandler)
    
    var environment : NetworkEnvironment {get set}
    
    var delegate : BackgroundNetworkManagerDelegate? {get set}
    
//    var keychain : KeychainManager {get}
    
    func upload(fileURL: URL, endpoint: Endpoint, allowsCellularAccess: Bool) throws -> NetworkManagerSessionTask
    
    func download(endpoint: Endpoint) throws -> NetworkManagerSessionTask
    
    func isUploading(networkManagerSessionTaskIdentifiers: [Int], completionHandler: @escaping (Bool) -> Void)
    func cancel(networkManagerSessionTaskIdentifiers: [Int], completionHandler: @escaping () -> Void)
    
}

public protocol BackgroundNetworkManagerDelegate : AnyObject {
    func didComplete(task: NetworkManagerSessionTask)
    func didFail(task: NetworkManagerSessionTask, with error: NetworkError)
    func didCompleteDownload(task: NetworkManagerSessionTask, data: Data)
}
