//
//  MockGoalsService.swift
//  adidas-task
//
//  Created by Jaime Domenech on 08/11/2020.
//

import Foundation


class MockGoalsService: GRService {
    
    var isFailing: Bool = false
    var hasBeenCalled = false
    lazy var returningData: [Goal] = generateMockGoals()
    
    // MARK: Getters
    
    func getDailyGoals(completion: @escaping Callback<[Goal]>) {
        hasBeenCalled = true
        guard !isFailing else {
            return completion(.failure(APIClientError.notDataRetrieved))
        }
        completion(.success(returningData))
    }
}

private extension MockGoalsService {
    
    func generateMockGoals() -> [Goal] {
        let mock1 = Goal(id: "1", title: "TestGoal1", description: "TestDescription1", type: Goal.GoalType.step.rawValue, goal: 100, reward: Reward(trophy: "silver_medal", points: 10))
        let mock2 = Goal(id: "2", title: "TestGoal2", description: "TestDescription2", type: Goal.GoalType.running.rawValue, goal: 100, reward: Reward(trophy: "silver_medal", points: 10))
        let mock3 = Goal(id: "3", title: "TestGoal3", description: "TestDescription3", type: Goal.GoalType.walking.rawValue, goal: 100, reward: Reward(trophy: "silver_medal", points: 10))
        return [mock1, mock2, mock3]
    }
}
