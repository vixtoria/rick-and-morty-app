//
//  CharacterInteractor.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation
import UIKit

public class CharacterInteractor: CharacterInteractorProtocol {

    weak var presenter: CharacterPresenterProtocol?
    
    //MARK: - Properties
    private var networkManager = URLSessionNetworkManager()
    
    //MARK: - Episodes
    func episodes(episodes: [String]) {
        let ids = episodes.map { $0.components(separatedBy: "/").last ?? "" }
//        let ids = episodes.reduce([]) { var partialResult, string in
//            partialResult.append(contentsOf: string.components(separatedBy: "/").last ?? "")
//        }
        
        networkManager.request(type: EpisodesResponse.self, endpoint: EpisodesEndpoint.all(ids)) { result in
            switch result {
            case .success(let response):
                guard let episodes = response.episodes else {
                    return
                }
                  
                self.presenter?.didFinishGettingEpisodes(episodes: episodes)
            case .failure(let error):
                
                if error == .noNetwork {
                    self.presenter?.didFinishGettingEpisodesWithErrors(error: "Please check your internet connection and try again")
                }
                
                self.presenter?.didFinishGettingEpisodesWithErrors(error: "Something went wrong loading episodes, please try again later.")
            }
        }
    }
    
}
