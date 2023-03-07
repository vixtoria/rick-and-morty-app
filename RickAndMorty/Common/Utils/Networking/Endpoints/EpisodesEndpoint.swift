//
//  EpisodesEndpoint.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 6/3/23.
//

import Foundation

enum EpisodesEndpoint {
    case all([String])
}

extension EpisodesEndpoint: Endpoint {
    
    var body: Data? {
        return nil
    }
    
    var path: String {
        switch self {
        case .all(let ids):
            return String(format: "episode/%@", arguments: [ids.joined(separator: ",")])
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .all(_):
            return .get
        }
    }
    
    var name: String? {
        return "CharactersEndpoint"
    }
    
    var requiresAuth: AuthorizationType {
        return .bearer
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .all(_):
            return [:]
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parametersEncoding: ParametersEncoding {
        switch self {
        case .all(_):
            return .url
        }
    }
}
