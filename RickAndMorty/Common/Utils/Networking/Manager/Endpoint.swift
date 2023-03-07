//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation

public enum ParametersEncoding {
	case url
	case json
}

public enum AuthorizationType {
    case none
    case bearer
}

public protocol Endpoint {
	var baseURL: URL { get }
	var path: String { get }
	var name: String? { get }
	var httpMethod: HTTPMethod { get }
    var requiresAuth: AuthorizationType { get }
	var parameters: [String: Any]? {get}
	var headers: [String: String]? { get }
	var parametersEncoding: ParametersEncoding { get }
    var body: Data? {get}
}

