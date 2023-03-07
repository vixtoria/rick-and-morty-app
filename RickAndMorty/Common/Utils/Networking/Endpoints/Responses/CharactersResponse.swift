//
//  CharactersResponse.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation

class CharactersResponse: Codable {
    var results: [Character]?

    enum CodingKeys : String, CodingKey {
        case results
    }

}
