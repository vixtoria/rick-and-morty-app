//
//  UIView+Extension.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 7/3/23.
//

import Foundation
import UIKit

extension UIView {
    func animationShow() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn],
            animations: {
                self.center.y -= self.bounds.height
                self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    
    func animationHide() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveLinear],
            animations: {
                self.center.y += self.bounds.height
                self.layoutIfNeeded()
        },  completion: {(_ completed: Bool) -> Void in
            self.isHidden = true
        })
    }
}
