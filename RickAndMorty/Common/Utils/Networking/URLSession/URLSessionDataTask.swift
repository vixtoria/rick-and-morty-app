//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation

extension URLSessionTask: NetworkManagerSessionTask {
	
    public var identifier: Int {
        return self.taskIdentifier
    }
    
    public var beginDate : Date? {
        get {
            return self.earliestBeginDate
        }
        
        set {
            self.earliestBeginDate = newValue
        }
    }
    
    public func resumeTask() {
		self.resume()
	}
	
}
