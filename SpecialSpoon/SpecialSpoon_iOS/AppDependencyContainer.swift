//
//  AppDependencyContainer.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import UIKit

/// Dependency injection engine
struct AppDependencyContainer {
    func makeRootViewController() -> RootViewController {
        let mainView = MainView()
        
        let model = SearchViewModel()
        
        let mainViewController = MainViewController(model: model,
                                                    userInterface: mainView,
                                                    searchUseCaseFactory: self)
        let rootViewController = RootViewController(mainViewController: mainViewController)
        
        return rootViewController
    }
}

extension AppDependencyContainer: SearchUseCaseUseCaseFactory {
    func makeSearchUseCase(model: SearchViewModel,
                           presentingViewController: UIViewController) -> UseCase {
        let useCase = SearchUseCase(model: model, presentingViewController: presentingViewController)
        return useCase
    }
}
