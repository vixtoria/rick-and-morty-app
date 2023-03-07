//
//  Species.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation

enum Species: String {
    case alive
    case dead
    case unknown
    
    var image: String {
        switch self {
        case .alive:
            return "alive.png"
        case .dead:
            return "dead.png"
        case .unknown:
            return "unknown.png"
        }
    }
}
