//
//  SplashProtocols.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation

//MARK: Router -
protocol SplashRouterProtocol: AnyObject {
    func showMain()
}

//MARK: Presenter -
protocol SplashPresenterProtocol: AnyObject {
    
    func presentMain()
}

//MARK: Interactor -
protocol SplashInteractorProtocol: AnyObject {
    
    var presenter: SplashPresenterProtocol?  { get set }
}

//MARK: View -
protocol SplashViewProtocol: AnyObject {
    
    var presenter: SplashPresenterProtocol?  { get set }

}
