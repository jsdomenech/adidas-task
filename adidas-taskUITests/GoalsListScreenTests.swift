//
//  GoalsListScreenTests.swift
//  adidas-taskUITests
//
//  Created by Jaime Domenech on 08/11/2020.
//

import XCTest

class GoalsListScreenTests: XCTestCase {
    
    
    let kStartupTimeOut: TimeInterval = 5
    
    // Cell Indexes: Defined in TestService
    
    let kStepGoalIndex = 0
    let kRunGoalIndex = 1
    let kWalkGoalIndex = 2
    
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {}

    func testListView_hasThreeGoals_whenIsLoadedWithTestGoalService() throws {
        let cell = app.tables.cells.element(boundBy: kStepGoalIndex)
        XCTAssertTrue(cell.waitForExistence(timeout: kStartupTimeOut))
        let cells = app.tables.cells.count
        XCTAssertEqual(cells, 3)
    }
    
    func testListView_stepsGoal_hasStepsLabel() throws {
        let cell = app.tables.cells.element(boundBy: kStepGoalIndex)
        XCTAssertTrue(cell.waitForExistence(timeout: kStartupTimeOut))
        XCTAssertTrue(cell.staticTexts["Steps"].isHittable)
    }
    
    func testListView_runGoal_hasRunLabel() throws {
        let cell = app.tables.cells.element(boundBy: kRunGoalIndex)
        XCTAssertTrue(cell.waitForExistence(timeout: kStartupTimeOut))
        XCTAssertTrue(cell.staticTexts["Run"].isHittable)
    }
    
    func testListView_walkGoal_hasWalkLabel() throws {
        let cell = app.tables.cells.element(boundBy: kWalkGoalIndex)
        XCTAssertTrue(cell.waitForExistence(timeout: kStartupTimeOut))
        XCTAssertTrue(cell.staticTexts["Walk"].isHittable)
    }
    
    func testListView_stepsGoal_hasNotRunLabel() throws {
        let cell = app.tables.cells.element(boundBy: kStepGoalIndex)
        XCTAssertTrue(cell.waitForExistence(timeout: kStartupTimeOut))
        XCTAssertFalse(cell.staticTexts["Run"].isHittable)
    }
    
    func testListView_runGoal_hasNotStepsLabel() throws {
        let cell = app.tables.cells.element(boundBy: kRunGoalIndex)
        XCTAssertTrue(cell.waitForExistence(timeout: kStartupTimeOut))
        XCTAssertFalse(cell.staticTexts["Steps"].isHittable)
    }
    
    func testListView_walkGoal_hasNotStepsLabel() throws {
        let cell = app.tables.cells.element(boundBy: kWalkGoalIndex)
        XCTAssertTrue(cell.waitForExistence(timeout: kStartupTimeOut))
        XCTAssertFalse(cell.staticTexts["Steps"].isHittable)
    }
}
