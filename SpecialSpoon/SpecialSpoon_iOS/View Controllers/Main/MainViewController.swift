//
//  MainViewController.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import UIKit
import Combine

class MainViewController: NiblessViewController {
    private let userInterface: MainView
    private let model: SearchViewModel
    private var subscriptions = Set<AnyCancellable>()
    private let searchUseCaseFactory: SearchUseCaseUseCaseFactory
    
    init(model: SearchViewModel,
         userInterface: MainView,
         searchUseCaseFactory: SearchUseCaseUseCaseFactory) {
        self.model = model
        self.userInterface = userInterface
        self.searchUseCaseFactory = searchUseCaseFactory
        
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        self.view = userInterface
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateNavBar()
        bindModel()
    }
}

extension MainViewController { // MARK: - Helpers
    @IBAction func presentNewSearch() {
        let useCase = searchUseCaseFactory.makeSearchUseCase(model: model,
                                                             presentingViewController: self)
        useCase.start()
    }
    
    private func populateNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                            target: self,
                                                            action: #selector(presentNewSearch))
        
        let historyTitle = NSLocalizedString("Saved Searches",
                                             comment: "Saved Searches")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: historyTitle,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(presentNewSearch))
    }
    
    private func bindModel() {
        model.$error
            .receive(on: DispatchQueue.main)
            .sink { (error) in
                if error != nil {
                    let alert = UIAlertController(title: error?.localizedDescription,
                                                  message: nil,
                                                  preferredStyle: .alert)
                    let cancelTitle = NSLocalizedString("Cancel",
                                                        comment: "Cancel")
                    let cancelAction = UIAlertAction(title: cancelTitle,
                                                     style: .cancel,
                                                     handler: nil)
                    alert.addAction(cancelAction)
                    self.present(alert,
                                 animated: true,
                                 completion: nil)
                }
            }
            .store(in: &subscriptions)
        
        model.$searchResults
            .receive(on: DispatchQueue.main)
            .sink { (results) in
                print(results)
//                self.userInterface.reloadData()
            }
            .store(in: &subscriptions)
    }
}
