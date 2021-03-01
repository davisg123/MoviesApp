//
//  Network.swift
//  MoviesApp
//
//  Created by Davis on 2/26/21.
//

import Foundation

protocol Network {
    func get(_ url: URL, completion: @escaping ((_ result: Result<Data, Error>) -> Void))
}

class HTTPNetwork: Network {
    static let sharedInstance = HTTPNetwork()
    
    enum NetworkError: Error {
        case unknownError
    }
    
    /// Make a get request at the specified URL and return the data or error in completion
    func get(_ url: URL, completion: @escaping ((_ result: Result<Data, Error>) -> Void)) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, _, error) in
            if let data = data {
                completion(.success(data))
            }
            else if let error = error {
                completion(.failure(error))
            }
            else {
                completion(.failure(NetworkError.unknownError))
            }
        }
        task.resume()
    }
}
