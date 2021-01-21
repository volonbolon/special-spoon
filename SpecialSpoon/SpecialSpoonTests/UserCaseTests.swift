//
//  UserCaseTests.swift
//  SpecialSpoonTests
//
//  Created by Ariel Rodriguez on 21/01/2021.
//

import XCTest
@testable import SpecialSpoon

class TestVC: NiblessViewController {
    var dismissHasBeenCalled = false
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag,
                      completion: completion)
        dismissHasBeenCalled = true
    }
}

class UserCaseTests: XCTestCase {
    func testUseCase() {
        let presentingVC = TestVC()
        let useCase = DismissSavedSearchesUseCase(presentingViewController: presentingVC)
        useCase.start()
        XCTAssertTrue(presentingVC.dismissHasBeenCalled, "presenting VC should have dismissed presented VC")
    }
}
