//
//  BaseViewController.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    //MARK: - Properties
    var spinnerView : UIView?
    
    //MARK: - Methods
    func displaySpinner()  {
        spinnerView = UIView.init(frame: self.view.bounds)
        spinnerView!.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        indicator.center = spinnerView!.center
        
        spinnerView!.addSubview(indicator)
        view.addSubview(spinnerView!)
    }
    
    func hideSpinner() {
        spinnerView?.removeFromSuperview()
    }
}
