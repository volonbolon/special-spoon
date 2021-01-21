//
//  SavedSearchesViewController.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import UIKit

class SavedSearchesViewController: NiblessViewController {
    private let userInterface: SavedSearchesTableView
    private let dataSource: UITableViewDataSource
    private let delegate: UITableViewDelegate
    
    public init(userInterface: SavedSearchesTableView) {
        self.userInterface = userInterface
        guard let ds = userInterface.dataSource, let del = userInterface.delegate else {
            fatalError("Unable to coompose table view")
        }
        self.dataSource = ds
        self.delegate = del
        
        super.init()
    }
    
    public override func loadView() {
        super.loadView()
        self.view = userInterface
    }
}

