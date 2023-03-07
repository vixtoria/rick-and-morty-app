//
//  UITableView+Extension.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation
import UIKit

extension UITableView {
    func dequeueReusableCellWithRegistration<T: UITableViewNibCell>(type: T.Type, indexPath: IndexPath) -> T {
        let identifier = T.reuseIdentifier
        
        if let cell = dequeueReusableCell(withIdentifier: identifier) as? T {
            return cell
        }
        
        register(T.nib, forCellReuseIdentifier: identifier)
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }
    
    func isLast(for indexPath: IndexPath) -> Bool {
        let indexOfLastSection = numberOfSections > 0 ? numberOfSections - 1 : 0
        let indexOfLastRowInLastSection = numberOfRows(inSection: indexOfLastSection) - 1

        return indexPath.section == indexOfLastSection && indexPath.row == indexOfLastRowInLastSection
    }
}
