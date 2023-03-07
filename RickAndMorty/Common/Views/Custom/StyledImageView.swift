//
//  StyledImageView.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 6/3/23.
//

import UIKit

@IBDesignable
class StyledImageView: UIImageView {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            updateCornerRadius()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        updateCornerRadius()
    }

    private func updateCornerRadius() {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
}

