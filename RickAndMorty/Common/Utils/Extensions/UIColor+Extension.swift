//
//  UIColor+Extension.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 5/3/23.
//

import Foundation
import UIKit

extension UIColor {
    class var borderColor: UIColor {
        get { return UIColor(named: "borderColor")! }
    }
    class var activeColor: UIColor {
        get { return UIColor(named: "lightGreen")! }
    }
    class var aliveColor: UIColor {
        get { return UIColor(named: "regularBlue")! }
    }
    class var deadColor: UIColor {
        get { return UIColor(named: "regularRed")! }
    }
    class var unknownColor: UIColor {
        get { return UIColor(named: "lightTextColor")! }
    }
    class var regularColor: UIColor {
        get { return UIColor(named: "regularGreen")! }
    }
}
