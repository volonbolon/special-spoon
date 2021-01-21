//
//  SearchViewModel.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import Foundation
import Combine

/// This is our source of truth. Here we have the results, and we expose them to be consumed by other parts of the app
class SearchViewModel: ObservableObject {
    weak var uxResponder: MainUXResponder?
    
    @Published var error: APIClientError? = nil
    @Published var searchResults: [SearchResult] = []
    @Published var receivingPage = false
    
    private let localStore: LocalRepository
    private var expectMorePages = true
    private var searchTerm: String?
    private var subscriptions = Set<AnyCancellable>()
    private let apiClient: APIClient
    private var offset = 0
    
    init(apiClient: APIClient = iTunesAPIClient(),
         localStore: LocalRepository = SavedSearchLocalRepository()) {
        self.apiClient = apiClient
        self.localStore = localStore
    }
    
    
    /// Resets the internal state and start a new search
    /// - Parameter term: a string used to query the API
    func searchForTerm(_ term: String) {
        searchTerm = term
        offset = 0
        expectMorePages = true
        
        searchResults = []
        
        retrieveNewPage()
    }
    
    
    /// Performs the actual call to the API
    func retrieveNewPage() {
        guard let term = searchTerm else {
            return
        }
        guard !receivingPage else {
            return
        }
        receivingPage = true
        apiClient.searchForTerm(term,
                                offset: offset,
                                pageSize: 20)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.error = error
                    self.expectMorePages = false
                }
                self.receivingPage = false
            }) { (results) in
                let resultsCount = results.count
                self.expectMorePages = resultsCount > 0
                self.searchResults += results
                self.offset += resultsCount
                self.error = nil
                
                // Saving the results in a local store
                self.localStore.saveSearch(savedSearch: self.searchResults,
                                           term: term)
            }
            .store(in: &subscriptions)
    }
    
    /// Populates the internal results store with content provided by the caller
    /// - Parameter results: An array of search results
    func useSavedSearch(results: [SearchResult]) {
        self.error = nil
        self.searchResults = results
    }
}

