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
    
    func testSavedSearches() throws {
        app.launch()
        
        app.navigationBars["SpecialSpoon.MainView"].buttons["Saved Searches"].tap()

        let savedTablesQuery = app.tables
        let numberOfCells = savedTablesQuery.children(matching: .cell).count
        XCTAssertEqual(numberOfCells, 1)
        
        let inUteroCell = savedTablesQuery.cells.element(boundBy: 0)
        inUteroCell.tap()
        
        let mainTablesQuery = app.tables["Search Results"]
        let numberOfCellsInMain = mainTablesQuery.children(matching: .cell).count
        XCTAssertEqual(numberOfCellsInMain, 2)
        
        let firstMainCell = mainTablesQuery.cells.element(boundBy: 0)
        let nameLabel = firstMainCell.staticTexts.element(matching: .any, identifier: "name label").label
        XCTAssertEqual(nameLabel, "SAVED>>In utero", "\(nameLabel) should be 'SAVED>>In utero'")
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
