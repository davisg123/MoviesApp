//
//  MovieSearchResult.swift
//  MoviesApp
//
//  Created by Davis on 2/26/21.
//

import Foundation

struct MovieSearchResultContainer: Codable {
    enum SearchError: String {
        case tooManyResults = "Too many results."
        case noResults = "Movie not found!"
    }
    
    let search: [MovieSearchResult]?
    
    let error: String?
    
    var errorResolved: SearchError? {
        guard let errorString = error else {
            return nil
        }
        return SearchError(rawValue: errorString)
    }
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case error = "Error"
    }
}

struct MovieSearchResult: Codable, Hashable {
    let title: String
    
    let year: String
    
    let imdbID: String
    
    let type: String
    
    let poster: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
