//
//  CharacterPresenter.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import UIKit

public class CharacterPresenter: CharacterPresenterProtocol {
    
    weak private var view: CharacterViewProtocol?
    var interactor: CharacterInteractorProtocol?
    private let router: CharacterRouterProtocol

    init(interface: CharacterViewProtocol, interactor: CharacterInteractorProtocol?, router: CharacterRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    //MARK: - Episodes
    func getEpisodes(episodes: [String]) {
        interactor?.episodes(episodes: episodes)
    }
    
    func didFinishGettingEpisodes(episodes: [Episode]) {
        DispatchQueue.main.async {
            self.view?.didFinishGettingEpisodes(episodes: episodes)
        }
    }
    
    func didFinishGettingEpisodesWithErrors(error: String) {
        DispatchQueue.main.async {
            self.view?.didFinishGettingEpisodesWithErrors(error: error)
        }
    }

}
