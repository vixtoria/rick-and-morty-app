//
//  UIAlertView.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation
import UIKit

class UIAlertView {
    
    class func showAcceptAlert(acceptTittle: String ,title: String, message: String, viewController: UIViewController, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: acceptTittle, style: .default) { (alertAction) in
            DispatchQueue.main.async { completion() }
        }
        alert.addAction(acceptAction)
        DispatchQueue.main.async {
            viewController.present(alert, animated: true)
        }
    }
    
    class func showAcceptAlert(title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        viewController.present(alert, animated: true)
    }
}
