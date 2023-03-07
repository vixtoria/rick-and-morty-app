//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation

extension URLComponents {
	
	public init(endpoint: Endpoint) {
		let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
		self.init(url: url, resolvingAgainstBaseURL: false)!
		
		guard endpoint.parametersEncoding == .url else {
			return
		}
		
		guard let parameters = endpoint.parameters else {
			return
		}
		
		queryItems = parameters.map { key, value in
			return URLQueryItem(name: key, value: String(describing: value))
		}
	}
}
