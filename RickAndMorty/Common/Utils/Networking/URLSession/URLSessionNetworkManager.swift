//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation

public final class URLSessionNetworkManager: NetworkManager {
	
	public var environment: NetworkEnvironment
	public var session: NetworkManagerSession
    	
	public init(session: NetworkManagerSession = URLSession.shared,
		 environment: NetworkEnvironment = NetworkEnvironment.defaultEnvironment) {
		self.session = session
		self.environment = environment
	}
	
	public func request<T>(type: T.Type, endpoint: Endpoint, completion: @escaping (Result<T, NetworkError>) -> ()) where T: Decodable {
		
        self.request(type: type, endpoint: endpoint) { (result: Result<T, NetworkErrorDetail<IgnoreDetail>>) in
            let newResult = result.mapError({ detail in
                return detail.error
            })
            completion(newResult)
        }
	}
	
	public func request(endpoint: Endpoint, completion: @escaping (Result<Void, NetworkError>) -> ()) {
        self.request(endpoint: endpoint) { (result: Result<Void, NetworkErrorDetail<IgnoreDetail>>) in
            let newResult = result.mapError({ detail in
                return detail.error
            })
            completion(newResult)
        }
	}
    
    public func request<T, U>(type: T.Type, endpoint: Endpoint, completion: @escaping (Result<T, NetworkErrorDetail<U>>) -> ()) where T: Decodable, U: Decodable {
        self.request(endpoint: endpoint) { (result: Result<Data?, NetworkErrorDetail<U>>) in
            switch result {
            case .success(let data):
                guard let data = data else {
                    return completion(.failure(NetworkErrorDetail(error: .noJSONData, detail: nil)))
                }
                                
                guard let model = try? JSONDecoder().decode(T.self, from: data) else {
                    return completion(.failure(NetworkErrorDetail(error: .parseData, detail: nil)))
                }
                
                completion(.success(model))
                case .failure(let errorDetail):
                completion(.failure(errorDetail))
            }
        }
    }
    
    public func request<U>(endpoint: Endpoint, completion: @escaping (Result<Void, NetworkErrorDetail<U>>) -> ()) where U: Decodable {
        self.request(endpoint: endpoint) { (result: Result<Data?, NetworkErrorDetail<U>>) in
            switch result {
            case .success(_):
                completion(.success(()))
            case .failure(let errorDetail):
                completion(.failure(errorDetail))
            }
        }
    }
    
    public func request<U>(endpoint: Endpoint, completion: @escaping (Result<Data?, NetworkErrorDetail<U>>) -> ()) where U: Decodable {
        
        do {
            let request = try urlRequest(forEndpoint: endpoint)
            let task = session.dataTask(request: request, completionHandler: { [weak self] data, response, error in
                
                guard let self = self else {
                    return
                }
                
                let httpResponse = response as? HTTPURLResponse
                self.printNetworkCall(request: request, data: data, httpResponse: httpResponse, error: error)
                
                let result: Result<Void, NetworkErrorDetail<U>> = self.handleResponse(endpoint: endpoint, data: data, response: httpResponse, error: error)
                
                switch result {
                case .success():
                    
                    completion(.success(data))
                    
                case .failure(let errorDetail):
                    completion(.failure(errorDetail))
                }
            })
            task.resumeTask()
        } catch let error as NetworkError {
            completion(.failure(NetworkErrorDetail(error: error, detail: nil)))
        } catch {
            completion(.failure(NetworkErrorDetail(error: .unknown, detail: nil)))
        }
        
    }
    
    
    private func printNetworkCall(request: URLRequest, data: Data?, httpResponse: HTTPURLResponse?, error: Error?) {
        print(request.fullDescription())
        if let httpResponse = httpResponse {
            print(httpResponse.debugDescription)
        } else if let error = error {
            print(error.localizedDescription)
        }
        if let data = data, let stringData = String(data: data, encoding: .utf8) {
            print(stringData)
        }
    }
	
}

extension URLSessionNetworkManager {
	
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

extension URLSessionNetworkManager {
	
    
    private func handleResponse<U: Decodable>(endpoint: Endpoint, data: Data?, response: HTTPURLResponse?, error: Error?) -> Result<Void, NetworkErrorDetail<U>> {
        
        guard error == nil else {
            return .failure(NetworkErrorDetail(error: .noNetwork, detail: nil))
        }
        
        guard let response = response else {
            return .failure(NetworkErrorDetail(error: .unknown, detail: nil))
        }
        
        let error = NetworkError(httpCode: response.statusCode)
        
        switch error {
        case .noError:
            return .success(())
        default:
            break
        }
        
        guard let data = data else {
            return .failure(NetworkErrorDetail(error: error, detail: nil))
        }
        
        guard let errorModel = try? JSONDecoder().decode(U.self, from: data) else {
            return .failure(NetworkErrorDetail(error: error, detail: nil))
        }
        
        return .failure(NetworkErrorDetail(error: error, detail: errorModel))
    }
	
}
