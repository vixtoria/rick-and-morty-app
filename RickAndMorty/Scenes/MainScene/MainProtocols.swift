//
//  MainProtocols.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation

//MARK: Router -
protocol MainRouterProtocol: AnyObject {
    func showCharacterDetail(character: Character)
}

//MARK: Presenter -
protocol MainPresenterProtocol: AnyObject {
    
    //MARK: - Characters
    func getCharacters(query: String, gender: String?, status: String?, page: Int)
    func didFinishGettingCharacters(results: [Character])
    func didFinishGettingCharactersWithErrors(error: String)

    func presentCharacter(character: Character)
}

//MARK: Interactor -
protocol MainInteractorProtocol: AnyObject {
    
    var presenter: MainPresenterProtocol?  { get set }
    
    //MARK: - Characters
    func characters(query: String, gender: String?, status: String?, page: Int)
}

//MARK: View -
protocol MainViewProtocol: AnyObject {
    
    var presenter: MainPresenterProtocol?  { get set }
    
    //MARK: - Characters
    func didFinishGettingCharacters(results: [Character])
    func didFinishGettingCharactersWithErrors(error: String)
}
