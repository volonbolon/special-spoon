//
//  MainViewController.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import UIKit

class MainViewController: NiblessViewController {
    private let userInterface: MainView
    
    init(userInterface: MainView) {
        self.userInterface = userInterface
        
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        self.view = userInterface
    }
}
