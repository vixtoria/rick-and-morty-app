//
//  ReusableView.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
