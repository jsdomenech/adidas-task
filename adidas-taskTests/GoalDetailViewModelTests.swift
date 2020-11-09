//
//  GoalDetailViewModelTests.swift
//  adidas-taskTests
//
//  Created by Jaime Domenech on 08/11/2020.
//

import XCTest

@testable import adidas_task

class GoalDetailViewModelTests: XCTestCase {

    let appDependencyContainer = AppDependencyContainer()
    var sut: GoalDetailViewModel?
    
    let mockGoal = Goal(id: "aaa", title: "title", description: "description", type: "step", goal: 100, reward: Reward(trophy: "silver_medal", points: 100))
    
    let mockActivityReport = ActivityReport(stepsCount: 140, walkingDistance: 1000, runningDistance: 2300)
    
    
    override func tearDownWithError() throws {
        sut = nil
    }

    func test_afterInit_goalPointsShouldReturn_rewardPoints() throws {
        
        sut = appDependencyContainer.makeGoalDetailViewModel(withGoal: mockGoal,
                                                             andActivityReport: mockActivityReport)
        
        let expectedValue = mockGoal.reward.points
        XCTAssertEqual(expectedValue, sut?.goalPoints)
    }
    
    func test_afterInit_goalAmountShouldReturn_goal() throws {
        
        sut = appDependencyContainer.makeGoalDetailViewModel(withGoal: mockGoal,
                                                             andActivityReport: mockActivityReport)
        
        let expectedValue = mockGoal.goal
        XCTAssertEqual(expectedValue, sut?.goalAmount)
    }
    
    func test_afterInit_goalTrophyShouldReturn_rewardTrophy() throws {
        
        sut = appDependencyContainer.makeGoalDetailViewModel(withGoal: mockGoal,
                                                             andActivityReport: mockActivityReport)
        
        let expectedValue = mockGoal.reward.trophy
        XCTAssertEqual(expectedValue, sut?.goalThropy)
    }
    
    func test_afterInit_goalTitleShouldReturn_goalTitle() throws {
        
        sut = appDependencyContainer.makeGoalDetailViewModel(withGoal: mockGoal,
                                                             andActivityReport: mockActivityReport)
        
        let expectedValue = mockGoal.title
        XCTAssertEqual(expectedValue, sut?.goalTitle)
    }
    
    func test_afterInit_goalDescriptionShouldReturn_description() throws {
        
        sut = appDependencyContainer.makeGoalDetailViewModel(withGoal: mockGoal,
                                                             andActivityReport: mockActivityReport)
        
        let expectedValue = mockGoal.description
        XCTAssertEqual(expectedValue, sut?.goalDescription)
    }
    
    func test_afterInit_goalTypeShouldReturn_goalType() throws {
        
        sut = appDependencyContainer.makeGoalDetailViewModel(withGoal: mockGoal,
                                                             andActivityReport: mockActivityReport)
        
        let expectedValue = mockGoal.description
        XCTAssertEqual(expectedValue, sut?.goalDescription)
    }
    
    func test_afterInit_goalProgressShouldReturn_wellFormatedGoalProgress_withMaxAmountOfTheGoal() throws {
        
        sut = appDependencyContainer.makeGoalDetailViewModel(withGoal: mockGoal,
                                                             andActivityReport: mockActivityReport)
        
        let expectedValue = "100/100"
        XCTAssertEqual(expectedValue, sut?.goalProgress)
    }
    
    func test_afterInit_goalProgressShouldReturn_wellFormatedGoalProgress() throws {
        
        let mockActivityReportTwo = ActivityReport(stepsCount: 80, walkingDistance: 1000, runningDistance: 2300)
        sut = appDependencyContainer.makeGoalDetailViewModel(withGoal: mockGoal,
                                                             andActivityReport: mockActivityReportTwo)
        
        let expectedValue = "80/100"
        XCTAssertEqual(expectedValue, sut?.goalProgress)
    }

}
