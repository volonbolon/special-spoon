//
//  UseCase.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import Foundation

/// Use cases are **command pattern** objects that know how to do a task needed by a user. Use cases know:
/// • What objects are needed to perform each step in a user task.
/// • What steps are needed to complete a user task.
/// • How to coordinate amongst object dependencies to complete a user task.
/// • How to manage asynchronous nature of I/O steps in a user task.
/// Use cases encapsulate all the object dependencies and all the orchestration amongst object dependencies. For example, a use case knows what objects are needed to perform networking and persistence tasks for a specific user task, such as liking a post, signing in, navigating to a screen, etc.
public protocol UseCase {
    func start()
}

