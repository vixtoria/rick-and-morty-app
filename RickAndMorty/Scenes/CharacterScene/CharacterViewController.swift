//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation
import UIKit

class CharacterViewController: BaseViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var statusView: StyledView!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.estimatedRowHeight = 44
            tableView.rowHeight = UITableView.automaticDimension
            tableView.allowsSelection = false
            tableView.separatorStyle = .none
        }
    }
    
    //MARK: - Properties
    var presenter: CharacterPresenterProtocol?
    
    var character: Character?
    private var episodes: [Episode] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: - Life cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.transition(with: containerView, duration: 1.0, options: .transitionFlipFromRight, animations: {
            self.containerView.alpha = 0.97
        }) { (completed) in
            UIView.animate(withDuration: 0.2,
                animations: {
                self.containerView.alpha = 1.0
            })
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options:[], animations: {
            self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4497070755)
        }, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    
        view.backgroundColor = .clear
    }
    
    //MARK: - Methods
    func setup() {
        let acceptCompletion = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
            return
        }
        guard let character = self.character else {
            UIAlertView.showAcceptAlert(acceptTittle: "Accept", title: "We're sorry", message: "Something went wrong, please try again later.", viewController: self, completion: acceptCompletion)
            return
        }
        
        self.definesPresentationContext = true
        
        UIView.animate(withDuration: 0.0,
            animations: {
            self.containerView.alpha = 0.0
        })
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissModal(_:)))
        view.addGestureRecognizer(tapGesture)
        
        if let image = character.image {
            imageView.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "default-image.png"))
        }
        
        nameLabel.text = character.name
        speciesLabel.text = character.speciesLabel
        statusLabel.text = character.status?.capitalized
        statusView.backgroundColor = character.statusColor
        locationLabel.text = character.location?.name
        
        if let episodes = character.episode {
            self.presenter?.getEpisodes(episodes: episodes)
        }
    }
    
    //MARK: - @IBActions
    @objc func dismissModal(_ sender: UITapGestureRecognizer) {
        
        UIView.transition(with: containerView, duration: 1.0, options: .transitionFlipFromRight, animations: {
            self.containerView.alpha = 0.97
        })
        
        UIView.animate(withDuration: 0.7, delay: 0.0, options:[], animations: {
            self.containerView.alpha = 0.0
            self.view.backgroundColor = .clear
        }) { (completed) in
            self.dismiss(animated: true, completion: nil)
        }
    }
}

//MARK: - Protocols
extension CharacterViewController: CharacterViewProtocol {
    
    func didFinishGettingEpisodes(episodes: [Episode]) {
        self.episodes = episodes
    }
    
    func didFinishGettingEpisodesWithErrors(error: String) {
        UIAlertView.showAcceptAlert(title: "Accept", message: "Something went wrong loading episodes, please try again later.", viewController: self)
    }
}

//MARK: - TableView
extension CharacterViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.episodes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithRegistration(type: EpisodeCell.self, indexPath: indexPath)

        cell.reload(episode: self.episodes[indexPath.row])
     
        return cell
    }
}

