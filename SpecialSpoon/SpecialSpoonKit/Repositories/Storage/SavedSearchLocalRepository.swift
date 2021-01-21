//
//  SavedSearchLocalRepository.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import Foundation
import VolonbolonKit

struct SavedSearchLocalRepository: LocalRepository {
    static let fileName = "savedSearch"
    
    func saveSearch(savedSearch: [SearchResult], term: String) {
        var saved = retrieveSavedSearches()
        saved[term] = savedSearch
        
        do {
            try VolonbolonKit.FileIOHelper.save(value: saved,
                                                named: SavedSearchLocalRepository.fileName)
        } catch {
            print(error)
        }
    }
    
    func retrieveSavedSearches() -> [String: [SearchResult]] {
        let saved: [String: [SearchResult]]
        do {
            saved = try VolonbolonKit.FileIOHelper.loadValue(named: SavedSearchLocalRepository.fileName)
        } catch let error as NSError {
            if error.code != 260 { // No file already saved
                print(error)
            }
            saved = [:]
        } catch {
            print(error)
            saved = [:]
        }
        return saved
    }
}
