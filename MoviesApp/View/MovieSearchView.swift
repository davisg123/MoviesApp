//
//  MovieSearchView.swift
//  MoviesApp
//
//  Created by Davis on 2/26/21.
//

import SwiftUI

struct MovieSearchView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = MovieSearchViewModel()
    
    @State private var loadingText = "Loading"

    @State private var selectedMovie: MovieSearchResult? = nil
    @State private var showingConfirm = false
    
    var body: some View {
        VStack(alignment: .center) {
            GreedyTextField(text: $viewModel.searchTerm, placeholder: "Find a Movie")
                .frame(width: 200, height: 40, alignment: .center)
                .padding(.top, 20.0)
            Spacer()
            if let statusText = viewModel.statusText {
                Text(statusText)
                    .font(.largeTitle)
            }
            else {
                VStack {
                    ScrollView {
                        let groupedObjs = viewModel.objs.splitInto(3)
                        ForEach(groupedObjs, id: \.self) { group in
                            HStack {
                                ForEach(group, id: \.self) { movie in
                                    MovieView(movie)
                                        .onTapGesture {
                                            selectedMovie = movie
                                            showingConfirm.toggle()
                                        }
                                        .alert(isPresented:$showingConfirm) {
                                            Alert(
                                                title: Text("Add '\(selectedMovie?.title ?? "-")' to your Watch List?"),
                                                primaryButton: .default(Text("Add")) {
                                                    guard let movie = selectedMovie else {
                                                        return
                                                    }
                                                    viewModel.didSelectMovie(movie)
                                                    presentationMode.wrappedValue.dismiss()
                                                },
                                                secondaryButton: .cancel()
                                            )
                                        }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
