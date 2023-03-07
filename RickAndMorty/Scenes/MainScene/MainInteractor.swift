//
//  MainInteractor.swift
//  RickAndMorty
//
//  Created by Victoria Rodriguez on 4/3/23.
//

import Foundation
import UIKit

public class MainInteractor: MainInteractorProtocol {

    weak var presenter: MainPresenterProtocol?
    
    //MARK: - Properties
    private var networkManager = URLSessionNetworkManager()
    
    //MARK: - Charactes
    func characters(query: String, gender: String?, status: String?, page: Int) {
        networkManager.request(type: CharactersResponse.self, endpoint: CharactersEndpoint.all(page, query, gender, status)) { result in
            switch result {
            case .success(let response):
                guard let results = response.results else {
                    return
                }

                self.presenter?.didFinishGettingCharacters(results: results)
            case .failure(let error):

                if error == .noNetwork {
                    self.presenter?.didFinishGettingCharactersWithErrors(error: "Please check your internet connection and try again")
                }

                self.presenter?.didFinishGettingCharacters(results: [])
            }
        }
    }
}
