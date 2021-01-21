//
//  SavedSearchLocalMockRepository.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 21/01/2021.
//

import Foundation

struct SavedSearchLocalMockRepository: LocalRepository {
    func saveSearch(savedSearch: [SearchResult], term: String) {}
    
    func retrieveSavedSearches() -> [String : [SearchResult]] {
        guard let path = Bundle.main.path(forResource: "saved_results",
                                          ofType: "json") else {
            return [:]
        }
        let url = URL(fileURLWithPath: path)
        do {
            
            let data = try Data(contentsOf: url)
            let payload = try JSONDecoder().decode([String:[SearchResult]].self,
                                 from: data)
            return payload
        } catch {
            print(error)
        }
        return [:]
    }
}
