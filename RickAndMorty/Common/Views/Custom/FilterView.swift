//
//  FilterView.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 5/3/23.
//

import Foundation
import UIKit

@IBDesignable
class FilterView: StyledView {
    
    //MARK: - @IBOutlets
    @IBOutlet var textField: UITextField!
    @IBOutlet var clearButton: UIButton!
    @IBOutlet var filterButton: UIButton!
    
    //MARK: - Properties
    var delegate: FilterViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    
    }
    
    //MARK: - @IBActions
    @IBAction func textFieldChanged(_ sender: Any) {
        guard let searchText = textField.text else {
            clearButton.isHidden = true
            return
        }
        
        clearButton.isHidden = searchText.isEmpty
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        delegate?.showFilterView()
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        textField.text = ""
        clearButton.isHidden = true
        delegate?.filter()
    }
    
    @IBAction func didBeginEditing(_ sender: Any) {
        guard let searchText = textField.text, !searchText.isEmpty else {
            return
        }
        textField.text = ""
    }

    @IBAction func didEndEditing(_ sender: Any) {
        if let searchText = textField.text, !searchText.isEmpty {
            return
        }
        textField.text = "Search.."
    }
}

protocol FilterViewDelegate {
    
    func showFilterView()
    func filter()
}
