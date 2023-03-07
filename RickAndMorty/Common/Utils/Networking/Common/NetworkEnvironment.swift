//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation

public struct NetworkEnvironment {
	
	public var name: String
	public var headers: [String : String] = [:]
	public var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData
	public let stub : Bool
	
	public init(name: String) {
		self.name = name
		self.stub = false
	}
	
    private init(name: String, stub: Bool) {
		self.name = name
		self.stub = stub
	}
}

public extension NetworkEnvironment {
	
	static func stubEnvironment(for name: String) -> NetworkEnvironment {
		return NetworkEnvironment(name: name, stub: true)
	}
	
	static var defaultEnvironment: NetworkEnvironment {
		var environment = NetworkEnvironment(name: "default")
		environment.headers = ["Content-Type": "application/json"]
		return environment
	}
	
}
