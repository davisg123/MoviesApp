//
//  LibraryViewModel.swift
//  MoviesApp
//
//  Created by Davis on 2/26/21.
//

import Foundation
import Combine

class LibraryViewModel: ObservableObject {
    @Published var movies = [MovieSearchResult]()

    @Published var showingToast = false {
        didSet {
            if showingToast {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self.showingToast = false
                }
            }
        }
    }
    
    private var publisherStorage: [AnyCancellable] = []
    
    private var initialLoadComplete = false
    
    init() {
        SharedLibraryPublisher.sharedInstance.$movies.sink { (movies) in
            self.movies = movies
            if self.initialLoadComplete {
                self.showingToast = true
            }
            self.initialLoadComplete = true
        }.store(in: &publisherStorage)
    }
}
