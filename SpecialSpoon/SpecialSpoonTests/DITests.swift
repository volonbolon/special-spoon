//
//  DITests.swift
//  SpecialSpoonTests
//
//  Created by Ariel Rodriguez on 21/01/2021.
//

import XCTest
@testable import SpecialSpoon

class DITests: XCTestCase {
    func testRootViewController() throws {
        let di = AppDependencyContainer()
        let vc = di.makeRootViewController()
        XCTAssertTrue(vc.isKind(of: RootViewController.self), "root should be a nav controller")
        XCTAssertTrue(vc.viewControllers.count == 1, "We should have a main view controller")
    }
}
