//
//  LocalRepository.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import Foundation

/// This is the interface that we should use to save and retrieve from disk a copy of the searches
protocol LocalRepository {
    func saveSearch(savedSearch: [SearchResult], term: String)
    func retrieveSavedSearches() -> [String: [SearchResult]]
}
