//
//  SearchResult.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import Foundation

struct Results: Codable {
    let results: [SearchResult]
}

struct SearchResult: Codable, Identifiable {
    let trackId: Int
    let trackName: String
    let previewUrl: String
    let collectionViewUrl: String
    let artistName: String
    let collectionName: String
    let artworkUrl100: String
    
    var id: Int {
        trackId
    }
}
