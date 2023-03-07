//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation

public protocol NetworkManagerSession {
	
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> ()
	
	func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> NetworkManagerSessionTask
	
}
