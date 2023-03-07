//
//  SplashRouter.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import UIKit

public class SplashRouter: SplashRouterProtocol {

    weak var viewController: UIViewController?
    weak var coordinator: SplashViewControllerDelegate?
    
    static func createModule(delegate: SplashViewControllerDelegate) -> UIViewController {
        let view = SplashViewController.loadFromNib()
        let interactor = SplashInteractor()
        let router = SplashRouter()
        let presenter = SplashPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        router.coordinator = delegate
        
        return view
    }
    
//    //MARK: - ShowMain
    func showMain() {
        coordinator?.goToMain()
    }
}

protocol SplashViewControllerDelegate: AnyObject {
    
    func goToMain()
}
