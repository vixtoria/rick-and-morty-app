//
//  FilterModal.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 6/3/23.
//

import Foundation
import UIKit

class FilterModal: BaseViewController {
    
    //MARK: - @IBoutlets
    @IBOutlet weak var gestureView: StyledView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var statusCollectionView: UICollectionView! {
        didSet {
            statusCollectionView.delegate = self
            statusCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var gendersCollectionView: UICollectionView! {
        didSet {
            gendersCollectionView.delegate = self
            gendersCollectionView.dataSource = self
        }
    }
    
    //MARK: - Properties
    var selectedGender: Gender?
    var selectedStatus: Status?
    private var status: [Status] = Status.allCases {
        didSet {
            statusCollectionView.reloadData()
        }
    }
    private var genders: [Gender] = Gender.allCases {
        didSet {
            gendersCollectionView.reloadData()
        }
    }
    
    var delegate: FilterModalDelegate?
    
    //MARK: - Life cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        containerView.animationShow()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        containerView.animationHide()
    }
    
    //MARK: - Methods
    func setup() {
        self.definesPresentationContext = true
        
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4497070755)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissModal(_:)))
        gestureView.addGestureRecognizer(tapGesture)
    }
    
    //MARK: - @IBActions
    @IBAction func filterButtonTapped(_ sender: Any) {
        delegate?.filter(selectedGender: self.selectedGender, selectedStatus: self.selectedStatus)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissModal(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - CollectionView
extension FilterModal: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.statusCollectionView { return status.count }
        if collectionView == self.gendersCollectionView { return genders.count }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithRegistration(type: FilterCell.self, indexPath: indexPath)
        if collectionView == self.statusCollectionView {
            cell.reload(name: self.status[indexPath.row].rawValue.capitalized, isSelected: selectedStatus != nil ? selectedStatus?.rawValue == self.status[indexPath.row].rawValue : false )
        }
        if collectionView == self.gendersCollectionView {
            cell.reload(name: self.genders[indexPath.row].rawValue.capitalized, isSelected: selectedGender != nil ? selectedGender?.rawValue == self.genders[indexPath.row].rawValue : false )
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(width: 100, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.statusCollectionView {
            if let status = self.selectedStatus, status.rawValue == self.status[indexPath.row].rawValue { selectedStatus = nil }
            else { selectedStatus = self.status[indexPath.row] }
        }
        if collectionView == self.gendersCollectionView {
            if let gender = self.selectedGender, gender.rawValue == self.genders[indexPath.row].rawValue { selectedGender = nil }
            else { selectedGender = self.genders[indexPath.row] }
        }
        collectionView.reloadData()
    }
}

protocol FilterModalDelegate {
    func filter(selectedGender: Gender?, selectedStatus: Status?)
}
