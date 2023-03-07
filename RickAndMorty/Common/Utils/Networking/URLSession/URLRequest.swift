//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation

extension URLRequest {
	
	public init(endpoint: Endpoint) {
		let urlComponents = URLComponents(endpoint: endpoint)
		
		self.init(url: urlComponents.url!)
		
		httpMethod = endpoint.httpMethod.rawValue
		endpoint.headers?.forEach { key, value in
			setValue(value, forHTTPHeaderField: key)
		}
		
		guard endpoint.parametersEncoding == .json else {
			return
		}
		
        if let body = endpoint.body {
            httpBody = body
        } else {
            guard let parameters = endpoint.parameters else {
                return
            }
            
            httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }
	}
        
    public func fullDescription() -> String {
        let newLine = "\n"
        let method = "\(self.httpMethod ?? "GET") "
        let url: String = "\(self.url?.absoluteString ?? "")\(newLine)"
        var header = ""
        var data: String = ""
        
        if let httpHeaders = self.allHTTPHeaderFields, httpHeaders.keys.count > 0 {
            for (key,value) in httpHeaders {
                header += "\(key): \(value)\(newLine)"
            }
        }
        
        if let bodyData = self.httpBody, let bodyString = String(data: bodyData, encoding: .utf8),  !bodyString.isEmpty {
            data = "\(bodyString)"
        }
        
        let result = method + url + header + newLine + data
        
        return result
    }
}
