//
//  SharedLibraryPublisher.swift
//  MoviesApp
//
//  Created by Davis on 2/26/21.
//

import Foundation
import Combine

class SharedLibraryPublisher: ObservableObject {
    @Published var movies = [MovieSearchResult]() {
        didSet {
            saveToDefaults(movies)
        }
    }
    
    static let sharedInstance = SharedLibraryPublisher()
    
    init() {
        movies = self.restoreFromDefaults()
    }
    
    func addMovie(_ movie: MovieSearchResult) {
        // no duplicate adds
        if !movies.contains(movie) {
            movies.append(movie)
        }
    }
    
    // MARK: - Persistence
    
    private static let movieKey = "user_movies"
    
    func saveToDefaults(_ movies: [MovieSearchResult]) {
        guard let data = try? JSONEncoder().encode(movies) else {
            return
        }
        
        UserDefaults.standard.setValue(data, forKey: type(of: self).movieKey)
    }
    
    func restoreFromDefaults() -> [MovieSearchResult] {
        guard let data = UserDefaults.standard.value(forKey: type(of: self).movieKey) as? Data else {
            return []
        }
        
        let movies = try? JSONDecoder().decode([MovieSearchResult].self, from: data)
        return movies ?? []
    }
}
