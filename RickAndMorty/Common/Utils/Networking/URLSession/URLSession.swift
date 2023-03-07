//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation

extension URLSession: NetworkManagerSession {
	
	public func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> NetworkManagerSessionTask {
		return dataTask(with: request, completionHandler: completionHandler)
	}
	
}
