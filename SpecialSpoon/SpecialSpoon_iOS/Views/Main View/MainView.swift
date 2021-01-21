//
//  MainView.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import UIKit

class MainView: NiblessTableView {
    static let cellIdentifier = "MainCellIdentifier"
    
    var loading = false {
        didSet {
            loading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        }
    }
    
    private var hierarchyNotReady = true
    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()    
    
    init(dataSource: UITableViewDataSource,
         delegate: UITableViewDelegate) {
        super.init(frame: .zero, style: .plain)
        
        
        
        self.register(MainTableViewCell.self,
                      forCellReuseIdentifier: MainView.cellIdentifier)
        
        self.dataSource = dataSource
        self.delegate = delegate
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        guard hierarchyNotReady else {
            return
        }
        
        constructHierarchy()
        activateConstraints()
    }
}

extension MainView { // MARK: - Helpers
    private func constructHierarchy() {
        self.backgroundView = activityIndicator
    }
    
    private func activateConstraints() {
        let centerX = activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let centerY = activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let toActivate = [
            centerX,
            centerY
        ]
        NSLayoutConstraint.activate(toActivate)
    }
}
