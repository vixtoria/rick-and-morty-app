//
//  Status.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation
import UIKit

enum Status: String, CaseIterable {
    case alive
    case dead
    case unknown 
    
    var color: UIColor {
        switch self {
        case .alive:
            return UIColor.aliveColor
        case .dead:
            return UIColor.deadColor
        case .unknown:
            return UIColor.unknownColor
        }
    }
}
