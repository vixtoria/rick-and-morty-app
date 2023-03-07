//
//  SplashPresenter.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import UIKit

public class SplashPresenter: SplashPresenterProtocol {
    
    weak private var view: SplashViewProtocol?
    var interactor: SplashInteractorProtocol?
    private let router: SplashRouterProtocol

    init(interface: SplashViewProtocol, interactor: SplashInteractorProtocol?, router: SplashRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    //MARK: - Main
    func presentMain() {
        router.showMain()
    }

}
