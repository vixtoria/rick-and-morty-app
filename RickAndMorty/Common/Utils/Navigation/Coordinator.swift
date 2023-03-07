//
//  Coordinator.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import UIKit

protocol Coordinator {
    
    var rootViewController: UINavigationController {get set}
    var childsCoordinators: [Coordinator] { set get }
    func start()
    
}
