//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 5/3/23.
//

import Foundation
import UIKit
import SDWebImage

class CharacterCell: UICollectionViewCell, UICollectionViewNibCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var statusView: StyledView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: StyledImageView!
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
//        lpgr.minimumPressDuration = 0.08
//        lpgr.delaysTouchesBegan = false
//        containerView.addGestureRecognizer(lpgr)
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//
//        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
//        lpgr.minimumPressDuration = 0.08
//        lpgr.delaysTouchesBegan = false
//        containerView.addGestureRecognizer(lpgr)
//    }
//
//    @objc func handleLongPress(gesture : UILongPressGestureRecognizer!) {
//        print("raw value : \(gesture.state.rawValue)")
//        if gesture.state.rawValue == 1 {
//            highlight(true)
//        }else{
//            highlight(false)
//        }
//
//    }
//
//    func highlight(_ touched: Bool) {
//        UIView.animate(withDuration: 0.5,
//                       delay: 0,
//                       usingSpringWithDamping: 1.0,
//                       initialSpringVelocity: 5.0,
//                       options: [.allowUserInteraction],
//                       animations: {
//                        self.transform = touched ? .init(scaleX: 0.95, y: 0.95) : .identity
//        }, completion: nil)
//    }

    func reload(character: Character){
        nameLabel.text = character.name
        numberLabel.text = character.number
        speciesLabel.text = character.speciesLabel
        statusLabel.text = character.statusLabel
        statusView.backgroundColor = character.statusColor
        
        if let image = character.image {
            imageView.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "default-image.png"))
        }
    }
}
