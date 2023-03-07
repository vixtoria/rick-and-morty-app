//
//  CharacterProtocols.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation

//MARK: Router -
protocol CharacterRouterProtocol: AnyObject {
//    func showEpisodeDetail(id: String)
}

//MARK: Presenter -
protocol CharacterPresenterProtocol: AnyObject {
    
    //MARK: - Episodes
    func getEpisodes(episodes: [String])
    func didFinishGettingEpisodes(episodes: [Episode])
    func didFinishGettingEpisodesWithErrors(error: String)

//    func presentEpisodes(episode: Episode)
}

//MARK: Interactor -
protocol CharacterInteractorProtocol: AnyObject {
    
    var presenter: CharacterPresenterProtocol?  { get set }

    //MARK: - Episodes
    func episodes(episodes: [String])
}

//MARK: View -
protocol CharacterViewProtocol: AnyObject {
    
    var presenter: CharacterPresenterProtocol?  { get set }
    
    //MARK: - Episodes
    func didFinishGettingEpisodes(episodes: [Episode])
    func didFinishGettingEpisodesWithErrors(error: String)
}
