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
    let id: Int
    let trackName: String
    let previewUrl: String
    let collectionViewUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case trackName
        case previewUrl
        case collectionViewUrl
    }
}
