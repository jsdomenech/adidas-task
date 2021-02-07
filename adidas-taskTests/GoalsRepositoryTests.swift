//
//  GoalsRepositoryTests.swift
//  adidas-taskTests
//
//  Created by Jaime Domenech on 09/11/2020.
//

import XCTest

@testable import adidas_task

class GoalsRepositoryTests: XCTestCase {
    
    var sut: GoalsRepository?
    var goalsService: MockGoalsService = MockGoalsService()
    var goalsStore: InMemoryStore = InMemoryStore()
    
    override func setUpWithError() throws {
        sut = GoalsRepository(withService: goalsService, andStore: goalsStore)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        goalsService = MockGoalsService()
        goalsStore = InMemoryStore()
    }
    
    func test_whenStoreIsEmpty_fetchDataFromService() {
        let mockGoal = Goal(id: "1", title: "test", description: "test", type: "step", goal: 1, reward: Reward(trophy: "silver_medal", points: 1))
        goalsService.returningData = [mockGoal]
        let expectationCallback = expectation(description: "Should run the callback closure")
        sut?.getDailyGoals(completion: { result in
            expectationCallback.fulfill()
            if case .success(let goals) = result, let goal = goals.first {
                XCTAssertEqual(mockGoal.id, goal.id)
            } else {
                XCTFail("Should succeed")
            }
        })
        waitForExpectations(timeout: 1)
    }
    
    func test_whenStoreIsEmpty_andApiFails_sholdReturnError() {
        goalsService.isFailing = true
        let expectationCallback = expectation(description: "Should run the callback closure")
        sut?.getDailyGoals(completion: { result in
            expectationCallback.fulfill()
            if case .failure = result {
                XCTAssert(true)
            } else {
                XCTFail("Should fail")
            }
        })
        waitForExpectations(timeout: 1)
    }
    
    func test_whenStoreHasData_apiShouldNotBeCaled() {
        let mockGoal = Goal(id: "1", title: "test", description: "test", type: "step", goal: 1, reward: Reward(trophy: "silver_medal", points: 1))
        sut?.saveDailyGoals([mockGoal])
        let expectationCallback = expectation(description: "Should run the callback closure")
        sut?.getDailyGoals(completion: { result in
            expectationCallback.fulfill()
            if case .success(let goals) = result, let goal = goals.first {
                XCTAssertEqual(mockGoal.id, goal.id)
                XCTAssertFalse(self.goalsService.hasBeenCalled, "API should not be called")
            } else {
                XCTFail("Should succeed")
            }
        })
        waitForExpectations(timeout: 1)
    }
    
}
