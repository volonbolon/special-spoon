//
//  AppDependencyContainer.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import Foundation

/// Dependency injection engine
struct AppDependencyContainer {
    func makeRootViewController() -> RootViewController {
        let mainView = MainView()
        
        let mainViewController = MainViewController(userInterface: mainView)
        let rootViewController = RootViewController(mainViewController: mainViewController)
        
        return rootViewController
    }
}
