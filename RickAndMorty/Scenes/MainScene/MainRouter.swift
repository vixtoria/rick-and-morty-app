//
//  MainRouter.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import UIKit

public class MainRouter: MainRouterProtocol {

    weak var viewController: UIViewController?
    weak var coordinator: MainViewControllerDelegate?
    
    static func createModule(delegate: MainViewControllerDelegate) -> UIViewController {
        let view = MainViewController.loadFromNib()
        let interactor = MainInteractor()
        let router = MainRouter()
        let presenter = MainPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        router.coordinator = delegate
        
        return view
    }
    
    //MARK: - ShowCharacteDetail
    func showCharacterDetail(character: Character) {
        coordinator?.goToCharacter(character: character)
    }
}

protocol MainViewControllerDelegate: AnyObject {
    
    func goToCharacter(character: Character)
}
