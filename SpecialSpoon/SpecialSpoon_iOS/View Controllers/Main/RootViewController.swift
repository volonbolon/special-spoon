//
//  RootViewController.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import UIKit

class RootViewController: NiblessNavigationController {
    init(mainViewController: MainViewController) {
        super.init()

        self.viewControllers = [mainViewController]
    }
}

