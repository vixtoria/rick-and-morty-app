//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation

public struct NetworkErrorDetail<T>: Error {
    public let error: NetworkError
    public let detail: T?
}

struct IgnoreDetail: Decodable {
    
}
