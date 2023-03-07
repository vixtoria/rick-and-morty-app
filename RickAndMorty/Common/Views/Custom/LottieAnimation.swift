//
//  LottieAnimation.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 7/3/23.
//

import UIKit
import Lottie

class LottieAnimation {
    
    static var animationView: AnimationView?
    
    static func show(view: UIView, color: UIColor){
        animationView = AnimationView(name: "morty", bundle: .local)
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 1.3
        animationView?.backgroundColor = color
        
        view.addSubview(animationView!)
        animationView?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView!.topAnchor.constraint(equalTo: view.topAnchor),
            animationView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animationView!.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        animationView!.play()
    }
    
    public static func hide(){
        animationView?.removeFromSuperview()
        animationView?.stop()
    }
}

extension Bundle {
    static let local: Bundle = Bundle.init(for: LottieAnimation.self)
}
