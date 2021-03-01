//
//  MovieSearchViewModel.swift
//  MoviesApp
//
//  Created by Davis on 2/26/21.
//

import Foundation
import Combine

class MovieSearchViewModel: ObservableObject {
    // MARK: API
    
    @Published var objs: [MovieSearchResult] = []
    
    @Published var searchTerm: String = "" {
        didSet {
            if searchTerm.count == 0 {
                return
            }
            movieSearchPublisher.search(searchTerm)
            statusText = "Loading"
        }
    }
    
    @Published var statusText: String? = nil

    init() {
        movieSearchPublisher.objects
            .receive(on: DispatchQueue.main)
            .sink { (error) in
                print(error)
                self.statusText = "Fatal Error"
        } receiveValue: { (val) in
            if let displayError = val.displayError {
                self.statusText = displayError
            }
            else if let movies = val.container?.search {
                self.statusText = nil
                self.objs = movies
            }
        }
        .store(in: &publisherStorage)
    }
    
    func didSelectMovie(_ movie: MovieSearchResult) {
        SharedLibraryPublisher.sharedInstance.addMovie(movie)
    }
    
    // MARK: Private
    
    private let movieSearchPublisher = MovieSearchPublisher()

    private var publisherStorage = [AnyCancellable]()
    
}
