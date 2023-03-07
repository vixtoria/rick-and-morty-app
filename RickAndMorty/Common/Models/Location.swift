//
//  Location.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation

struct Location: Codable {
    let id: Int?
    let name: String?
    let type: String?
    let dimension: String?
    let url: String?
    
    enum CodingKeys : String, CodingKey {
        case id
        case name
        case type
        case dimension
        case url
    } 
}
