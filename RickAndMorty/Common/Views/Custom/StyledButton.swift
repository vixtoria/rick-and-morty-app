//
//  StyledButton.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 7/3/23.
//

import UIKit

@IBDesignable
class StyledButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            updateCornerRadius()
        }
    }
    @IBInspectable var borderColour: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColour.cgColor
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var round: Bool = false {
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

        //update corner radius for view
        updateCornerRadius()
    }

    private func updateCornerRadius() {
        if round {
            layer.cornerRadius = frame.height / 2
        } else {
            layer.cornerRadius = cornerRadius
        }
        layer.masksToBounds = true
    }

}

