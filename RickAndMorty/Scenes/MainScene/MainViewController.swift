//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation
import UIKit

class MainViewController: BaseViewController {
    
    //MARK: - @IBoutlets
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var filterView: FilterView!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    //MARK: - Properties
    var presenter: MainPresenterProtocol?
    
    private var lastIndexLoaded = 0
    private let animationDuration: Double = 0.8
    
    private var page: Int = 1
    private var isLastPage: Bool = false
    
    private var selectedGender: Gender?
    private var selectedStatus: Status?
    
    private var characters: [Character] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    private var query: String {
        guard let searchText = searchTextField.text, searchText != "Search.." else {
            return ""
        }
        return searchText
    }
    
    //MARK: - Life cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        filterView.delegate = self
        hideKeyboardWhenTappedAround()
        
        self.presenter?.getCharacters(query: query, gender: selectedGender?.rawValue, status: selectedStatus?.rawValue, page: page)
    }
    
    //MARK: - Methods
//    func setup() {
//        filterView.delegate = self
//
//        let tap = UITapGestureRecognizer(target: self, action:  #selector(dismissKeyboard(_:)))
//        view.addGestureRecognizer(tap)
//    }
    
    func load(){
        isLastPage = false
        lastIndexLoaded = 0
        page = 1
        collectionView.setContentOffset(.zero, animated: false)
        self.presenter?.getCharacters(query: query, gender: selectedGender?.rawValue, status: selectedStatus?.rawValue, page: page)
    }
    
    func loadMore() {
        if isLastPage { return }
        page+=1
        self.presenter?.getCharacters(query: query, gender: selectedGender?.rawValue, status: selectedStatus?.rawValue, page: page)
    }
    
    //MARK: - @IBActions
    @IBAction func searchFieldChanged(_ sender: Any) {
        load()
    }
    
//    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
//        searchTextField.resignFirstResponder()
//    }
    
}

//MARK: - Protocols
extension MainViewController: MainViewProtocol {

    func didFinishGettingCharacters(results: [Character]) {
        if (page == 1) { characters = [] }
        if results.isEmpty {
            isLastPage = true
            return
        }
        characters.append(contentsOf: results)
    }

    func didFinishGettingCharactersWithErrors(error: String) {
        if (page == 1) { characters = [] }
    }
}

extension MainViewController: FilterViewDelegate {
    
    func showFilterView() {
        let filterModal = FilterModal.loadFromNib()
        filterModal.modalPresentationStyle = .overCurrentContext
        filterModal.modalTransitionStyle = .crossDissolve
        filterModal.delegate = self
        filterModal.selectedStatus = self.selectedStatus
        filterModal.selectedGender = self.selectedGender
        self.present(filterModal, animated: true, completion: nil)
    }
    
    func filter() {
        load()
    }
}

extension MainViewController: FilterModalDelegate {
    
    func filter(selectedGender: Gender?, selectedStatus: Status?) {
        self.selectedGender = selectedGender
        self.selectedStatus = selectedStatus
        filter()
    }
    
}

//MARK: - CollectionView
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = MainCollectionViewSection(rawValue: indexPath.section)!
        
        switch section {
        case .EmptySection:
            return collectionView.dequeueReusableCellWithRegistration(type: EmptyCell.self, indexPath: indexPath)
        case .CharacterSection:
            let cell = collectionView.dequeueReusableCellWithRegistration(type: CharacterCell.self, indexPath: indexPath)

            let character = self.characters[indexPath.row]
            cell.reload(character: character)
            
            if (indexPath.row > lastIndexLoaded) {
                cell.alpha = 0
                UIView.animate(withDuration: animationDuration) {
                    cell.alpha = 1
                }
                lastIndexLoaded = indexPath.row
            }
            
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return MainCollectionViewSection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = MainCollectionViewSection(rawValue: section)!
        
        switch section {
        case .EmptySection:
            return (characters.count != 0 || searchTextField.text == "" || searchTextField.text == "Search..") ? 0 : 1
        case .CharacterSection:
            return characters.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = MainCollectionViewSection(rawValue: indexPath.section)!
        
        switch section {
        case .EmptySection:
            return
        case .CharacterSection:
            let cell = collectionView.cellForItem(at: indexPath)

            UIView.animate(withDuration: 0.4,
                animations: {
                cell?.alpha = 0.9
                cell?.transform = CGAffineTransform.identity.scaledBy(x: 1.04, y: 1.04)
            }) { (completed) in
                UIView.animate(withDuration: 0.5,
                    animations: {
                    cell?.alpha = 1.0
                    cell?.transform = CGAffineTransform.identity
                })
                
                self.presenter?.presentCharacter(character: self.characters[indexPath.row])
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = MainCollectionViewSection(rawValue: indexPath.section)!

        switch section {
        case .EmptySection:
            return CGSize(width: view.frame.width, height: 200)
        case .CharacterSection:
            return CGSize(width: (view.frame.width / 2) - 20, height: 260)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if characters.isEmpty { return }
        let section = MainCollectionViewSection(rawValue: indexPath.section)
        if section == .EmptySection { return }
        
        let lastSectionIndex = collectionView.numberOfSections - MainCollectionViewSection.count
        let lastRowIndex = collectionView.numberOfItems(inSection: lastSectionIndex) - 1
        if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex - 5 {
            self.loadMore()
        }
    }
}

////MARK: - TableView
//extension MainViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let section = MainTableViewSection(rawValue: section)!
//
//        switch section {
//        case .EmptySection:
//            return (products.count != 0 || searchTextField.text == "") ? 0 : 1
//        case .ProductSection:
//            return products.count
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let section = MainTableViewSection(rawValue: indexPath.section)!
//
//        switch section {
//        case .EmptySection:
//            return tableView.dequeueReusableCellWithRegistration(type: EmptyCell.self, indexPath: indexPath)
//        case .ProductSection:
//            let cell = tableView.dequeueReusableCellWithRegistration(type: ProductCell.self, indexPath: indexPath)
//
//            let product = self.products[indexPath.row]
//            cell.reload(product: product)
//
//            return cell
//        }
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let section = MainTableViewSection(rawValue: indexPath.section)
//        if section == .EmptySection { return }
//
//        guard let productId = self.products[indexPath.row].id else {
//            return
//        }
//        self.presenter?.presentProduct(id: productId)
//    }
//
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if products.isEmpty { return }
//        let section = MainTableViewSection(rawValue: indexPath.section)
//        if section == .EmptySection { return }
//
//        let lastSectionIndex = tableView.numberOfSections - MainTableViewSection.count
//        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
//        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
//            let spinner = UIActivityIndicatorView(style: .medium)
//            spinner.startAnimating()
//            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
//
//            self.tableView.tableFooterView = spinner
//            self.tableView.tableFooterView?.isHidden = false
//
//            self.loadMore()
//        }
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return MainTableViewSection.count
//    }
//}

enum MainCollectionViewSection: Int {
    case CharacterSection
    case EmptySection
    static var count = 2
}
