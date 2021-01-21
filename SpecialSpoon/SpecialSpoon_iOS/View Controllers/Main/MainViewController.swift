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
    private let mainUseCaseFactory: MainViewUseCaseFactory
    private let dataSource: UITableViewDataSource
    private let delegate: UITableViewDelegate
    
    init(model: SearchViewModel,
         userInterface: MainView,
         searchUseCaseFactory: SearchUseCaseUseCaseFactory,
         mainUseCaseFactory: MainViewUseCaseFactory) {
        self.model = model
        self.userInterface = userInterface
        self.searchUseCaseFactory = searchUseCaseFactory
        self.mainUseCaseFactory = mainUseCaseFactory
        
        guard let ds = userInterface.dataSource,
              let del = userInterface.delegate else {
            fatalError("Unable to coompose table view")
        }
        self.dataSource = ds
        self.delegate = del
        
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
    private func populateNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                            target: model.uxResponder,
                                                            action: #selector(presentNewSearch))
        
        let historyTitle = NSLocalizedString("Saved Searches",
                                             comment: "Saved Searches")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: historyTitle,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(presentSavedSearches))
    }
    
    
    /// the observable publishers in the model are our source of truth.
    /// When they update, we are informed, and we can update our views
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
                self.userInterface.reloadData()
            }
            .store(in: &subscriptions)
    }
}

extension MainViewController: MainUXResponder {
    func presentNewSearch() {
        let useCase = searchUseCaseFactory.makeSearchUseCase(model: model,
                                                             presentingViewController: self)
        useCase.start()
    }
    
    func presentSavedSearches() {
        let useCase = searchUseCaseFactory.makePresentSavedSearchesUseCase(model: model,
                                                                           presentingViewController: self)
        useCase.start()
    }
    
    func playSampleButtonTapped(sender: UIButton) {
        let correctedPoint = sender.convert(sender.bounds.origin,
                                            to: userInterface)
        if let indexPath = userInterface.indexPathForRow(at: correctedPoint) {
            let searchResult = model.searchResults[indexPath.row]
            if let url = URL(string: searchResult.previewUrl) {
                let useCase = mainUseCaseFactory.makePlaySampleUseCase(url: url)
                useCase.start()
            }
        }
    }
}
