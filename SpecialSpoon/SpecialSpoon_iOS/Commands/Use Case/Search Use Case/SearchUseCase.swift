//
//  SearchUseCase.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import UIKit

class SearchUseCase: UseCase {
    let model: SearchViewModel
    let presentingViewController: UIViewController
    
    init(model: SearchViewModel,
         presentingViewController: UIViewController) {
        self.model = model
        self.presentingViewController = presentingViewController
    }
    
    public func start() {
        let title = NSLocalizedString("Search for new music", comment: "Search for new music")
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = NSLocalizedString("Search", comment: "Search")
        }
        let cancelTitle = NSLocalizedString("Cancel", comment: "Cancel")
        let cancelAction = UIAlertAction(title: cancelTitle,
                                         style: .cancel) { _ in }
        alert.addAction(cancelAction)
        
        let searchTitle = NSLocalizedString("Search", comment: "Search")
        let searchAction = UIAlertAction(title: searchTitle,
                                         style: .default) { (action) in
            guard let textFields = alert.textFields,
                  let textField = textFields.first,
                  let searchTerm = textField.text else {
                return
            }
            self.model.searchForTerm(searchTerm)
        }
        alert.addAction(searchAction)
        presentingViewController.present(alert,
                                         animated: true,
                                         completion: nil)
    }
}

protocol SearchUseCaseUseCaseFactory {
    func makeSearchUseCase(model: SearchViewModel,
                           presentingViewController: UIViewController) -> UseCase
}
