//
//  ShadowView.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import UIKit

@IBDesignable
class ShadowView: UIView {
    var shadowLayer = CAShapeLayer()
    var borderLayer = CAShapeLayer()

    @IBInspectable
    var cornerRadius: CGFloat = 0.0 {
        didSet {
            setShadow()
        }
    }

    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return shadowLayer.shadowOffset
        }
        set {
            shadowLayer.shadowOffset = newValue
            setShadow()
        }
    }

    @IBInspectable
    var shadowOpacity: Float {
        get {
            return shadowLayer.shadowOpacity
        }
        set {
            shadowLayer.shadowOpacity = newValue
            setShadow()
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat{
        get {
            return shadowLayer.shadowRadius
        }
        set {
            shadowLayer.shadowRadius = newValue
            setShadow()
        }
    }

    private func setShadow() {
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        borderLayer.path = shadowLayer.path
        borderLayer.backgroundColor = UIColor.clear.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        shadowLayer.fillColor = UIColor.white.cgColor

        shadowLayer.shadowColor = UIColor.black.cgColor
//        shadowLayer.shadowColor = UIColor(red: 236 / 255, green: 239 / 255, blue: 244 / 255, alpha: 1.0).cgColor
        shadowLayer.shadowPath = shadowLayer.path
    }

    override var frame: CGRect {
        didSet {
            setShadow()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        commonInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        setShadow()
    }

    func commonInit() {
        layer.insertSublayer(borderLayer, at: 0)
        layer.insertSublayer(shadowLayer, at: 0)

        self.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.shadowOpacity = 0.13
        self.shadowRadius = 7.0
        layer.masksToBounds = true
        clipsToBounds = false
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

}
