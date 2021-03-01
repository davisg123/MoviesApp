//
//  MovieView.swift
//  MoviesApp
//
//  Created by Davis on 2/26/21.
//

import SwiftUI

struct MovieView: View {

    private let movie: MovieSearchResult
    
    init(_ movie: MovieSearchResult) {
        self.movie = movie
    }
    
    var body: some View {
        VStack {
            AsyncImageView(imageUrl: URL(string: movie.poster))
                .frame(width: 100, height: 150, alignment: .center)
            AsyncImageView(imageUrl: URL(string: movie.poster))
                .blur(radius: 10.0)
                .opacity(0.35)
                .frame(width: 80, height: 20, alignment: .center)
            Text(self.movie.title + "(\(self.movie.year))")
                .font(.system(size: 12.0, weight: .bold, design: .default))
                .frame(width: 100, height: 40, alignment: .center)
                .padding(.top, -20)
        }
        .padding(.all, 10.0)
    }
}

