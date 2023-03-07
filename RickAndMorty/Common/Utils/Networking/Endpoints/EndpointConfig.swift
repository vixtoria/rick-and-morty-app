//
//  EndpointConfig.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation

public class Constants {
    
    static var baseUrl = "https://rickandmortyapi.com/api/"
}

extension Endpoint {
    
    var baseURL: URL {
        guard let url = URL(string: Constants.baseUrl) else {
            fatalError("Project Base URL needed")
        }
        
        return url
    }
    
    var body: Data? {
        return nil
    }
    
}
