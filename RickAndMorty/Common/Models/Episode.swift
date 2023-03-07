//
//  Episode.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation

struct Episode: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    
    var title: String {
        return "\(episode) \(name)"
    }
    
    enum CodingKeys : String, CodingKey {
        case id
        case name
        case air_date
        case episode
        case characters
    }
}
