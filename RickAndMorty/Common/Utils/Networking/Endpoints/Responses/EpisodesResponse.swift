//
//  EpisodesResponse.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 6/3/23.
//

import Foundation

class EpisodesResponse: Codable {
    var episodes: [Episode]?
    
    required init(from decoder: Decoder) throws {
        var episodes = [Episode]()
        
        do {
            var container = try decoder.unkeyedContainer()
            
            if let count = container.count {
                episodes.reserveCapacity(count)
            }
        
            while !container.isAtEnd {
                if let element = try? container.decode(Episode.self) {
                    episodes.append(element)
                }
            }

        } catch {
            let values = try decoder.container(keyedBy: Episode.CodingKeys.self)

            let id = try values.decode(Int.self, forKey: .id)
            let name = try values.decode(String.self, forKey: .name)
            let airDate = try values.decode(String.self, forKey: .air_date)
            let episodeUrl = try values.decode(String.self, forKey: .episode)
            let characters = try values.decode([String].self, forKey: .characters)
            
            let episode = Episode(id: id, name: name, air_date: airDate, episode: episodeUrl, characters: characters)

            episodes.append(episode)
        }
        
        self.episodes = episodes
    }
}
