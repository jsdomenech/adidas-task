//
//  GoalsListViewModelTests.swift
//  adidas-taskTests
//
//  Created by Jaime Domenech on 08/11/2020.
//

import XCTest

@testable import adidas_task

class GoalsListViewModelTests: XCTestCase {
    
    let appDependencyContainer = AppDependencyContainer()
    var sut: GoalsListViewModel?
    
    let mockGoal = Goal(id: "aaa", title: "title", description: "description", type: "step", goal: 100, reward: Reward(trophy: "silver_medal", points: 100))
    
    override func tearDownWithError() throws {
        sut = nil
    }

    func test_whenServiceFetchData_viewModelShouldHaveGoals() throws {
        
        let testService = MockGoalsService()
        testService.isFailing = false
        testService.returningData = [mockGoal]
        
        sut = appDependencyContainer.makeGoalsListViewModel(goalService: testService)
        
        let expectationCallback = expectation(description: "Should run the callback closure")
        sut?.reloadTableViewHandler = { goals in
            XCTAssertFalse(goals.isEmpty)
            expectationCallback.fulfill()
        }
        sut?.loadData()
        waitForExpectations(timeout: 1)
    }
    
    func test_whenServiceFails_tableviewCallback_shouldNotBeCalled() throws {
        
        let testService = MockGoalsService()
        testService.isFailing = true
        
        sut = appDependencyContainer.makeGoalsListViewModel(goalService: testService)
        
        let expectationCallback = expectation(description: "Should not run the callback closure")
        expectationCallback.isInverted = true
        
        sut?.reloadTableViewHandler = { goals in
            expectationCallback.fulfill()
        }
        sut?.loadData()
        waitForExpectations(timeout: 1)
    }
    
    func test_whenAskForHelathAuth_tryToRequestAccess_toHealthKit() {
        
        let testService = MockActivityService()
        
        sut = appDependencyContainer.makeGoalsListViewModel(activityService: testService)
        
        let expectationCallback = expectation(description: "Should run the callback closure")
        testService.onRequestForAuthorization = {
            expectationCallback.fulfill()
        }
        sut?.askForHealthAuthorization()
        waitForExpectations(timeout: 1)
    }
}
