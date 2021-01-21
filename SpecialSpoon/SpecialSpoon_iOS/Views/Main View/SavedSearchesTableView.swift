//
//  SavedSearchesTableView.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import UIKit

class SavedSearchesTableView: NiblessTableView {
    static let cellIdentifier = "SavedSearchesCellIdentifier"
    
    init(dataSource: UITableViewDataSource,
         delegate: UITableViewDelegate) {
        super.init(frame: .zero, style: .plain)
        
        self.register(UITableViewCell.self,
                      forCellReuseIdentifier: SavedSearchesTableView.cellIdentifier)
        
        self.dataSource = dataSource
        self.delegate = delegate
    }
}

