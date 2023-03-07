//
//  StyledTextFieldWithImage.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import UIKit

class StyledTextFieldWithImage: StyledTextField {

    @IBInspectable var logoImage: UIImage? {
        didSet {
            paddingView?.image = logoImage?.withRenderingMode(.alwaysTemplate)
            paddingView?.tintColor = UIColor(red: 142 / 255, green: 142 / 255, blue: 147 / 255, alpha: 1.0)
        }
    }
    override var errorState: Bool {
        get {
            super.errorState
        }
        set {
            super.errorState = newValue
            paddingView?.tintColor = newValue ? UIColor(red: 255 / 255, green: 71 / 255, blue: 65 / 255, alpha: 1.0) : UIColor(red: 142 / 255, green: 142 / 255, blue: 147 / 255, alpha: 1.0)
        }
    }
    private var paddingView: UIImageView?

    override func updateLeftPadding() {
        if leftPadding > 1.0 {
            let containerView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: frame.height))
            paddingView = UIImageView(image: logoImage?.withRenderingMode(.alwaysTemplate))
            paddingView?.frame = CGRect(x: 0, y: 0, width: leftPadding, height: frame.height)
            paddingView?.contentMode = .center
            paddingView?.tintColor = UIColor(red: 142 / 255, green: 142 / 255, blue: 147 / 255, alpha: 1.0)
            containerView.addSubview(paddingView!)
            leftView = containerView
            leftViewMode = .always
        } else {
            paddingView = nil
            leftView = nil
            leftViewMode = .never
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if let superview = paddingView?.superview {
            paddingView?.frame = CGRect(x: 0, y: 0, width: superview.frame.width, height: superview.frame.height)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        commonInit()
    }
}

extension StyledTextFieldWithImage{

    func commonInit() {
        layer.borderWidth = 0
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 8.0
        self.layer.shadowOffset = CGSize.zero // Use any CGSize
        self.layer.shadowColor = UIColor.lightGray.cgColor

    }
}
