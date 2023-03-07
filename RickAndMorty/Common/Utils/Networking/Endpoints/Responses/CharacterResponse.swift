//
//  CharacterResponse.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation

class CharacterResponse: Codable {
    var character: Character?

    enum CodingKeys : String, CodingKey {
        case character
    }
    
}
