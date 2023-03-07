//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation

public protocol NetworkManagerSessionTask {
    
    var identifier: Int {get}
    
    var beginDate: Date? {get set}
	
	func resumeTask()
	
}
