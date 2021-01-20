//
//  MainUXResponder.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import UIKit


/// User interface objects know when a user interacts with the device, taps a button or enters some text, but do not know how to handle those events. That’s where the interaction responder comes in. The user interface tells the interaction responder what to do, and the interaction responder knows how to do it.
@objc protocol MainUXResponder: class {
    func presentNewSearch()
    func presentSavedSearches()
    func playButtonTappedSample(sender: UIButton)
}
