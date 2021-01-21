//
//  DetailsViewController.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import UIKit

class DetailsViewController: NiblessViewController {
    private let userInterface: DetailsView
    
    init(userInterface: DetailsView) {
        self.userInterface = userInterface
        
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        
        self.view = userInterface
    }
}
