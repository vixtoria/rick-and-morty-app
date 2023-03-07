//
//  UiCollectionView+Extension.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 6/3/23.
//

import Foundation
import UIKit

extension UICollectionView {
    func dequeueReusableCellWithRegistration<T: UICollectionViewNibCell>(type: T.Type, indexPath: IndexPath) -> T {
        let identifier = T.reuseIdentifier
        
        register(T.nib, forCellWithReuseIdentifier: identifier)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T
    }
    
//    func isLast(for indexPath: IndexPath, section: Int) -> Bool {
////        let indexOfLastSection = numberOfSections > 0 ? numberOfSections - 1 : 0
//        let indexOfLastRowInLastSection = numberOfItems(inSection: section) - 1
//
//        return indexPath.section == section && indexPath.row == indexOfLastRowInLastSection
//    }
}
