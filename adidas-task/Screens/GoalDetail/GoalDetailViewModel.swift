//
//  GoalDetailViewModel.swift
//  adidas-task
//
//  Created by Jaime Domenech on 08/11/2020.
//

class GoalDetailViewModel {
    
    // MARK: Properties
    
    var goalPoints: Int { goal.reward.points }
    var goalAmount: Int { goal.goal }
    var goalThropy: String { goal.reward.trophy }
    var goalTitle: String { goal.title }
    var goalDescription: String { goal.description }
    var goalType: Goal.GoalType { goal.goalType }
    var goalProgress: String {
        var activityAmount = goal.goalType.activityAmount(for: activityReport)
        if activityAmount > goalAmount { activityAmount = goalAmount }
        return "\(activityAmount)/\(goalAmount)"
    }
    
    // MARK: Dependencies
    
    private let goal: Goal
    private let activityReport: ActivityReport
    
    // MARK: LifeCycle
    
    init(withGoal goal: Goal, andActivityReport activityReport: ActivityReport) {
        self.goal = goal
        self.activityReport = activityReport
    }
}
