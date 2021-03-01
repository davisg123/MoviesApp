//
//  AsyncImageView.swift
//  MoviesApp
//
//  Created by Davis on 2/26/21.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    func load(_ url: URL) {
        // Ignore missing images
        if (url.host == nil) {
            return
        }
        
        HTTPNetwork.sharedInstance.get(url) { (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            case .failure(_):
                break
            }
        }
    }
}

struct AsyncImageView: View {
    
    @ObservedObject private var imageLoader = ImageLoader()
    
    var placeholder = Image("poster-placeholder")

    init(imageUrl: URL?) {
        if let url = imageUrl {
            imageLoader.load(url)
        }
    }
    
    var body: some View {
        if let image = imageLoader.image {
            return Image(uiImage: image)
                .resizable()
        }
        return placeholder
            .resizable()
    }
}
