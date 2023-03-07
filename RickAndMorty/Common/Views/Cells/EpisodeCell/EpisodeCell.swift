//
//  EpisodeCell.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 6/3/23.
//

import Foundation
import UIKit

class EpisodeCell: UITableViewCell, UITableViewNibCell {

    @IBOutlet weak var nameLabel: UILabel!

    func reload(episode: Episode){
        nameLabel.text = episode.title
    }
}
