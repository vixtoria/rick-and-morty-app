//
//  CharacterRouter.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import UIKit

public class CharacterRouter: CharacterRouterProtocol {

    weak var viewController: UIViewController?
    weak var coordinator: CharacterViewControllerDelegate?
    
    static func createModule(delegate: CharacterViewControllerDelegate, character: Character) -> UIViewController {
        let view = CharacterViewController.loadFromNib()
        let interactor = CharacterInteractor()
        let router = CharacterRouter()
        let presenter = CharacterPresenter(interface: view, interactor: interactor, router: router)
        
        view.character = character
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        router.coordinator = delegate
        
        return view
    }
}

protocol CharacterViewControllerDelegate: AnyObject {
    
//    func goToEpisode(episode: Episode)
}
