//
//  GoalDetailsScreenTests.swift
//  adidas-taskUITests
//
//  Created by Jaime Domenech on 09/11/2020.
//

import XCTest

class GoalDetailsScreenTests: XCTestCase {
    
    
    let kStartupTimeOut: TimeInterval = 5
    let kNavigationWaitingTimeOut: TimeInterval = 2
    
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

    func testListView_tapOnStepCell_showsStepDetails() throws {
        let cell = app.tables.cells.element(boundBy: kStepGoalIndex)
        XCTAssertTrue(cell.waitForExistence(timeout: kStartupTimeOut))
        cell.tap()
        let stepTitle = app.staticTexts["Steps"]
        let goalDescription = app.staticTexts["TestDescription1"]
        XCTAssertTrue(stepTitle.waitForExistence(timeout: kNavigationWaitingTimeOut))
        XCTAssertTrue(stepTitle.isHittable)
        XCTAssertTrue(goalDescription.waitForExistence(timeout: kNavigationWaitingTimeOut))
        XCTAssertTrue(goalDescription.isHittable)
    }
    
    func testListView_tapOnRunCell_showsRunDetails() throws {
        let cell = app.tables.cells.element(boundBy: kRunGoalIndex)
        XCTAssertTrue(cell.waitForExistence(timeout: kStartupTimeOut))
        cell.tap()
        let stepTitle = app.staticTexts["Run"]
        let goalDescription = app.staticTexts["TestDescription2"]
        XCTAssertTrue(stepTitle.waitForExistence(timeout: kNavigationWaitingTimeOut))
        XCTAssertTrue(stepTitle.isHittable)
        XCTAssertTrue(goalDescription.waitForExistence(timeout: kNavigationWaitingTimeOut))
        XCTAssertTrue(goalDescription.isHittable)
    }
    
    func testListView_tapOnWalkCell_showsWalkDetails() throws {
        let cell = app.tables.cells.element(boundBy: kWalkGoalIndex)
        XCTAssertTrue(cell.waitForExistence(timeout: kStartupTimeOut))
        cell.tap()
        let stepTitle = app.staticTexts["Walk"]
        let goalDescription = app.staticTexts["TestDescription3"]
        XCTAssertTrue(stepTitle.waitForExistence(timeout: kNavigationWaitingTimeOut))
        XCTAssertTrue(stepTitle.isHittable)
        XCTAssertTrue(goalDescription.waitForExistence(timeout: kNavigationWaitingTimeOut))
        XCTAssertTrue(goalDescription.isHittable)
    }
}
