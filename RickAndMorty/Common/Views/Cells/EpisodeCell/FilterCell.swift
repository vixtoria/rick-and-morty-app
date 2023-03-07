//
//  FilterCell.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 6/3/23.
//

import Foundation
import UIKit

class FilterCell: UICollectionViewCell, UICollectionViewNibCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!

    func reload(name: String, isSelected: Bool){
        self.nameLabel.text = name
        self.containerView.backgroundColor = isSelected ? .activeColor : .regularColor
    }
}
