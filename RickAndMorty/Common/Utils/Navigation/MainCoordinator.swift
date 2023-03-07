//
//  MainCoordinator.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var rootViewController: UINavigationController
    var childsCoordinators: [Coordinator] = []
        
    init(navigationController: UINavigationController) {
        self.rootViewController = navigationController
        self.rootViewController.interactivePopGestureRecognizer?.isEnabled = false
        self.rootViewController.isNavigationBarHidden = true
    }
    
    func start() {
        let viewController = SplashRouter.createModule(delegate: self)
        rootViewController.pushViewController(viewController, animated: true)
    }
}

extension MainCoordinator: SplashViewControllerDelegate {
    
    func goToMain() {
        let viewController = MainRouter.createModule(delegate: self)
        viewController.modalTransitionStyle = .crossDissolve
        rootViewController.pushViewController(viewController, animated: true)
    }
}

extension MainCoordinator: MainViewControllerDelegate {
    
    func goToCharacter(character: Character) {
        let viewController = CharacterRouter.createModule(delegate: self, character: character)
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        rootViewController.present(viewController, animated: true, completion: nil)
    }
}

extension MainCoordinator: CharacterViewControllerDelegate {

}


