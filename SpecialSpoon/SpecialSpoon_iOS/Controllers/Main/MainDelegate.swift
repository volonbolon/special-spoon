//
//  MainDelegate.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import UIKit

class MainDelegate: NSObject, UITableViewDelegate {
    private let model: SearchViewModel
    
    init(model: SearchViewModel) {
        self.model = model
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if (offsetY > (contentHeight - (scrollView.frame.height * 4))) {
            model.retrieveNewPage()
        }
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let searchResult = model.searchResults[indexPath.row]
        guard let url = URL(string: searchResult.collectionViewUrl) else {
            return
        }
        model.uxResponder?.navigateToDetails(url: url)
    }
}
