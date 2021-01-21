//
//  SavedSearchesDataSource.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import UIKit

class SavedSearchesDataSource: NSObject {
    var dismissSearchesUseCase: UseCase?
    
    private let model: SearchViewModel
    private let searches: [String: [SearchResult]]
    private let keys: [String]
    
    public init(model: SearchViewModel,
                searches: [String: [SearchResult]]) {
        self.model = model
        self.searches = searches
        self.keys = Array(searches.keys)
        super.init()
    }
}

extension SavedSearchesDataSource: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keys.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SavedSearchesTableView.cellIdentifier, for: indexPath)
        
        let savedSearchTerm = keys[indexPath.row]
        cell.textLabel?.text = savedSearchTerm
        
        return cell
    }
}

extension SavedSearchesDataSource: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let search = searches[keys[indexPath.row]] {
            model.useSavedSearch(results: search)
            dismissSearchesUseCase?.start()
        }
    }
}

