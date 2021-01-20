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
    private var subscriptions = Set<AnyCancellable>()
    private let apiClient: APIClient
    
    @Published var error: APIClientError? = nil
    @Published var searchResults: [SearchResult] = []
    @Published var receivingPage = false
    private var expectMorePages = true
    private var searchTerm: String?
    
    private var offset = 0
    
    init(apiClient: APIClient = iTunesAPIClient()) {
        self.apiClient = apiClient
    }
    
    func searchForTerm(_ term: String) {
        searchTerm = term
        offset = 0
        expectMorePages = true
        
        searchResults = []
        
        retrieveNewPage()
    }
    
    func retrieveNewPage() {
        guard let term = searchTerm else {
            return
        }
        guard !receivingPage else {
            return
        }
        receivingPage = true
        apiClient.searchForTerm(term, offset: offset, pageSize: 20)
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
            }
            .store(in: &subscriptions)
    }
}

