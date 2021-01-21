//
//  AppDependencyContainer.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import UIKit

/// Dependency injection engine
struct AppDependencyContainer {
    
    var remoteAPI: APIClient {
        return iTunesAPIClient()
    }
    
    var makeSavedSearchPool: LocalRepository {
        return SavedSearchLocalRepository()
    }
    
    /// This is the root view controller. We start the application here
    /// - Returns: A navigation controller with a table view controller were we are going to show search results
    func makeRootViewController() -> RootViewController {
        let model = SearchViewModel(apiClient: remoteAPI)
        
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
    
    
    /// Produces the list of saved searches
    /// - Parameter model: source of truth
    /// - Returns: a view controller encapsulating the list of saved searches
    func makeSavedSearchesViewController(model: SearchViewModel) -> SavedSearchesViewController {
        let savedSearchesPool = makeSavedSearchPool
        let savedSearches = savedSearchesPool.retrieveSavedSearches()
        
        let savedSearchesDataSource = SavedSearchesDataSource(model: model, searches: savedSearches)
        
        let userInterface = SavedSearchesTableView(dataSource: savedSearchesDataSource, delegate: savedSearchesDataSource)
        
        let vc = SavedSearchesViewController(userInterface: userInterface)
        
        let dismissSearchesUseCase = self.makeDismissSavedSearchesUseCase(presentingViewController: vc)
        savedSearchesDataSource.dismissSearchesUseCase = dismissSearchesUseCase
        
        return vc
    }
}

extension AppDependencyContainer: SearchUseCaseUseCaseFactory {
    func makeSearchUseCase(model: SearchViewModel,
                           presentingViewController: UIViewController) -> UseCase {
        let useCase = SearchUseCase(model: model, presentingViewController: presentingViewController)
        return useCase
    }
    
    func makePresentSavedSearchesUseCase(model: SearchViewModel,
                                         presentingViewController: UIViewController) -> UseCase {
        let useCase = PresentSavedSearchesUseCase(model: model,
                                                  presentingViewController: presentingViewController)
        return useCase
    }
    
    func makeDismissSavedSearchesUseCase(presentingViewController: UIViewController) -> UseCase {
        let useCase = DismissSavedSearchesUseCase(presentingViewController: presentingViewController)
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
