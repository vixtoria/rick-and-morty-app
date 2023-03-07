//
//  StyledTextField.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import UIKit

@IBDesignable
class StyledTextField: UITextField {

    @IBInspectable var leftPadding: CGFloat = 20.0 {
        didSet {
            updateLeftPadding()
        }
    }
    
    @IBInspectable var rightPadding: CGFloat = 20.0 {
        didSet {
            updateRightPadding()
        }
    }
    
    @IBInspectable var borderColour: UIColor = UIColor.white {
        didSet {
            updateBorderColor()
        }
    }
    
    @IBInspectable var selectedBorderColour: UIColor = UIColor(red: 207 / 255, green: 207 / 255, blue: 207 / 255, alpha: 1.0) {
        didSet {
            updateBorderColor()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    var errorState = false {
        didSet {
            updateBorderColor()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }

    private func customInit() {
        updateLeftPadding()
        updateRightPadding()
    }

    func updateLeftPadding() {
        if leftPadding > 1.0 {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: frame.height))
            leftView = paddingView
            leftViewMode = .always
        } else {
            leftView = nil
            leftViewMode = .never
        }
    }
    
    func updateRightPadding() {
        if rightPadding > 1.0 {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: rightPadding, height: frame.height))
            rightView = paddingView
            rightViewMode = .always
        } else {
            rightView = nil
            rightViewMode = .never
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func updateBorderColor() {
        if errorState {
            layer.borderColor = UIColor(red: 255 / 255, green: 71 / 255, blue: 65 / 255, alpha: 1.0).cgColor
        } else {
            if isFirstResponder || text != "" {
                layer.borderColor = borderColour.cgColor
            } else {
                layer.borderColor = selectedBorderColour.cgColor
            }
        }
    }

    override func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        if result {
            updateBorderColor()
        }
        return result
    }

    override func resignFirstResponder() -> Bool {
        let result = super.resignFirstResponder()
        if result {
            updateBorderColor()
        }
        return result
    }
}

