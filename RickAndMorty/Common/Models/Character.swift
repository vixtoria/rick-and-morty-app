//
//  Character.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation
import UIKit

struct Character: Codable {
    let id: Int
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin: Location?
    let location: Location?
    let image: String?
    let episode: [String]?
    
    var number: String {
        return String(format: "%02d", self.id)
    }
    
    var statusColor: UIColor {
        guard let status = status, let statusType = Status(rawValue: status.lowercased()) else {
            return Status.unknown.color
        }
        
        return statusType.color
    }
    
    var statusLabel: String {
        guard let status = status, let statusType = Status(rawValue: status.lowercased()) else {
            return Status.unknown.rawValue
        }
        
        return statusType.rawValue.capitalized
    }
    
    var speciesLabel: String {
        guard let species = species else {
            return ""
        }
        
        return species.firstWord
    }
    
    enum CodingKeys : String, CodingKey {
        case id
        case name
        case status
        case species
        case type
        case gender
        case origin
        case location
        case image
        case episode
    }
}
