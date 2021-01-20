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
        let model = SearchViewModel()
        
        let datasource = MainDataSource(model: model)
        let delegate = MainDelegate(model: model)
        let mainView = MainView(dataSource: datasource, delegate: delegate)
        
        let mainViewController = MainViewController(model: model,
                                                    userInterface: mainView,
                                                    searchUseCaseFactory: self,
                                                    mainUseCaseFactory: self)
        model.uxResponder = mainViewController
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

extension AppDependencyContainer: MainViewUseCaseFactory {
    /// Produces a use case that plays a sample track from a URL
    /// - Parameter url: url pointing to the sample track
    /// - Returns: use case fully inatiated. The caller needs to call start whenerver ready
    func makePlaySampleUseCase(url: URL) -> UseCase {
        let useCase = PlaySampleUseCase(url: url)
        return useCase
    }
}
