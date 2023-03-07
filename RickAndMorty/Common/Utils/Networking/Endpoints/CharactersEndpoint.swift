//
//  CharactersEndpoint.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation

enum CharactersEndpoint {
    case all(Int, String, String?, String?)
    case detail(String)
}

extension CharactersEndpoint: Endpoint {
    
    var body: Data? {
        return nil
    }
    
    var path: String {
        switch self {
        case .all(_,_,_,_):
            return "character/"
        case .detail(let id):
            return String(format: "character/%@", arguments: [id])
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .all(_,_,_,_):
            return .get
        case .detail(_):
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
        case .all(let page, let name, let gender, let status):
            var data = ["page": page, "name": name] as [String : Any]
            if gender != nil { data["gender"] = gender }
            if status != nil { data["status"] = status }
            return data
        case .detail(_):
            return [:]
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parametersEncoding: ParametersEncoding {
        switch self {
        case .all(_,_,_,_):
            return .url
        case .detail(_):
            return .url
        }
    }
}
