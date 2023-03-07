//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation

public enum NetworkError: Error {
	
	case unknown
	case noJSONData
	case parseData
	case badRequest
	case unauthorized
	case forbidden
	case notFound
	case clientFault
	case serverFault
	case refreshToken
	case noNetwork
    case noError
    
    init(httpCode: Int) {
        switch httpCode {
        case 200...299:
            self = .noError
        case 400:
            self = .badRequest
        case 401:
            self = .unauthorized
        case 403:
            self = .forbidden
        case 404:
            self = .notFound
        case 405...499:
            self = .clientFault
        case 500...599:
            self = .serverFault
        default:
            self = .unknown
        }
    }
	
}
