//
//  MainPresenter.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import UIKit

public class MainPresenter: MainPresenterProtocol {

    weak private var view: MainViewProtocol?
    var interactor: MainInteractorProtocol?
    private let router: MainRouterProtocol

    init(interface: MainViewProtocol, interactor: MainInteractorProtocol?, router: MainRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    //MARK: - Charactes
    func getCharacters(query: String, gender: String?, status: String?, page: Int) {
        interactor?.characters(query: query, gender: gender, status: status, page: page)
    }
    
    func didFinishGettingCharacters(results: [Character]) {
        DispatchQueue.main.async {
            self.view?.didFinishGettingCharacters(results: results)
        }
    }
    
    func didFinishGettingCharactersWithErrors(error: String) {
        DispatchQueue.main.async {
            self.view?.didFinishGettingCharactersWithErrors(error: error)
        }
    }
    
    func presentCharacter(character: Character) {
        router.showCharacterDetail(character: character)
    }
}
