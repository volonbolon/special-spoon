//
//  SpecialSpoonUITests.swift
//  SpecialSpoonUITests
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import XCTest

class SpecialSpoonUITests: XCTestCase {
    var app: XCUIApplication!
    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearch() throws {
        app.launch()
        
        app.navigationBars["SpecialSpoon.MainView"].buttons["Search"].tap()
        
        let alert = app.alerts["Search for new music"]
        
        let textField = alert.textFields["search for term"]
        textField.typeText("In Utero")
        
        let searchButton = alert.buttons["Search"]
        searchButton.tap()
        
        let tablesQuery = app.tables
        let numberOfCells = tablesQuery.children(matching: .cell).count
        XCTAssertEqual(numberOfCells, 2)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
