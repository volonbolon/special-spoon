//
//  MainUXResponder.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import UIKit

/// User interface objects know when a user interacts with the device, taps a button or enters some text, but do not know how to handle those events.
/// That’s where the interaction responder comes in. The user interface tells the interaction responder what to do, and the interaction responder knows how to do it.
@objc protocol MainUXResponder: class {
    
    /// Informs the UX that the user wants to start a new search
    /// We need to produce some sort of action sheet to let the user enter the search term
    func presentNewSearch()
    func presentSavedSearches()
    
    /// Let's play the sample track
    func playSampleButtonTapped(sender: UIButton)
    
    
    /// When the users selects a search result, the view instructs the responder to push it onto the stack.
    /// Because of the separation of concerns, the responder can choose how to best show the content
    /// - Parameter url: URL pointing to web content
    func navigateToDetails(url: URL)
}

protocol MainDependencyFactory {
    func makeDetailsViewController(url: URL) -> DetailsViewController
}
