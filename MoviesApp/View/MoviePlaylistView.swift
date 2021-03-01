//
//  MoviePlaylistView.swift
//  MoviesApp
//
//  Created by Davis on 2/26/21.
//

import Foundation
import SwiftUI

struct MoviePlaylistView: View {
    @ObservedObject var libraryViewModel = LibraryViewModel()
    
    @State private var loadingText = "Loading"
    
    @State private var showingSearch = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Your Watch List")
                        .font(.largeTitle)
                    ScrollView {
                        // groups of 3
                        let groupedMovies = libraryViewModel.movies.splitInto(3)
                        ForEach(groupedMovies, id: \.self) { group in
                            HStack {
                                ForEach(group, id: \.self) { movie in
                                    NavigationLink(destination: MovieDetailView(movie)) {
                                        MovieView(movie)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                    }
                }
                if libraryViewModel.showingToast {
                    ZStack {
                        Rectangle()
                            .cornerRadius(10.0)
                            .frame(width: 260, height: 140, alignment: .center)
                            .foregroundColor(Color(UIColor.secondarySystemBackground.cgColor))
                        VStack {
                            Text("Ok, added!")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .bold, design: .default))
                            Text("My favorite color is blue")
                                .foregroundColor(.blue)
                                .font(.system(size: 16, weight: .regular, design: .default))
                        }
                    }
                    .animation(.easeInOut(duration: 0.5))
                }
            }
            .navigationBarItems(trailing:
                                    Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 40.0, weight: .bold, design: .default))
                                    .foregroundColor(.white)
                                    .onTapGesture {
                                        showingSearch.toggle()
                                    }
            )
            .sheet(isPresented: $showingSearch) {
                MovieSearchView()
                    .preferredColorScheme(.dark)
            }
        }
        .onAppear {
            if libraryViewModel.movies.count == 0 {
                showingSearch.toggle()
            }
        }
    }
}

struct MoviePlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
