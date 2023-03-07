//
//  SplashViewController.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation
import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    //MARK: - Properties
    var presenter: SplashPresenterProtocol?
    
    @IBOutlet weak var containerView: UIView!

    //MARK: - Life cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
                
        LottieAnimation.show(view: self.containerView, color: .clear)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.presenter?.presentMain()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        LottieAnimation.hide()
    }
}

extension SplashViewController: SplashViewProtocol {
    
}
