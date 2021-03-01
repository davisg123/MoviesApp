//
//  MovieSearchPublisher.swift
//  MoviesApp
//
//  Created by Davis on 2/26/21.
//

import Foundation
import Combine

class MovieSearchPublisher {
    
    enum SearchError: Error {
        case invalidUrl
        case invalidSearchTerm
    }
    
    // MARK: API
    
    struct Result {
        var container: MovieSearchResultContainer?
        var displayError: String?
    }
    
    var objects: AnyPublisher<Result, Error> {
        return objectSubject.eraseToAnyPublisher()
    }
    
    func search(_ term: String) {
        guard var components = URLComponents(url: Constants.omDBEndpoint, resolvingAgainstBaseURL: false) else {
            objectSubject.send(completion: .failure(SearchError.invalidUrl))
            return
        }
        
        let apiKeyQuery = URLQueryItem(name: "apikey", value: Constants.apiKey)
        let searchQuery = URLQueryItem(name: "s", value: term)
        
        components.queryItems = [apiKeyQuery, searchQuery]
        
        guard let url = components.url else {
            objectSubject.send(completion: .failure(SearchError.invalidSearchTerm))
            return
        }
        
        fetch(dataAt: url)
    }
    
    func fetch(dataAt url: URL) {
        network.get(url) { (result) in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let obj = try decoder.decode(MovieSearchResultContainer.self, from: data)
                    self.objectSubject.send(Result(container: obj, displayError: obj.error))
                } catch {
                    self.objectSubject.send(Result(container: nil, displayError: "Failed to parse"))
                }
            case .failure(_):
                self.objectSubject.send(Result(container: nil, displayError: "Failed to connect."))
            }
        }
    }
    
    // MARK: Private
    
    var objectSubject = PassthroughSubject<Result, Error>()
    
    var network: Network = HTTPNetwork.sharedInstance
}
