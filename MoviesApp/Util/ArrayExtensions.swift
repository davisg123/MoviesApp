//
//  ArrayExtensions.swift
//  MoviesApp
//
//  Created by Davis on 2/26/21.
//

import Foundation

extension Array {
    func splitInto(_ chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            Array(self[$0..<Swift.min($0 + chunkSize, self.count)])
        }
    }
}
