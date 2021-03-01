//
//  MoviesApp.swift
//  MoviesApp
//
//  Created by Davis on 2/26/21.
//

import SwiftUI

@main
struct MoviesApp: App {
    var body: some Scene {
        WindowGroup {
            MoviePlaylistView()
                .preferredColorScheme(.dark)
        }
    }
}
