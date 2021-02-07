//
//  AppDependencyContainer.swift
//  adidas-task
//
//  Created by Jaime Domenech on 07/11/2020.
//
//  Container to manage all the creation and injections of dependencies
//

import Foundation
import UIKit

class AppDependencyContainer {
    
    // MARK: - Properties: Long-lived dependencies
    
    let goalsRepository: GoalsRepository
    
    // MARK: - LifeCycle
    
    public init(){
        /*
         Long-lived dependencies are initialized here. We don't want to expose that methods to create again the dependency.
         */
        goalsRepository = AppDependencyContainer.makeGoalsRepository()

    }
    
    static private func makeGoalsRepository() -> GoalsRepository {
        GoalsRepository(withService: BigChallengeService(), andStore: JSONLocalStore())
    }
    
    func makeMainViewController() -> UIViewController {
        let vc = UINavigationController(rootViewController: makeGoalsListViewController())
        vc.navigationBar.prefersLargeTitles = true
        return vc
    }
    
    func makeGoalsListViewController() -> GoalsListViewController {
        GoalsListViewController(viewModel: makeGoalsListViewModel())
    }
    
    func makeGoalsListViewModel(goalService: GRService = MockGoalsService(),
                                activityService: ActivityService = MockActivityService()) -> GoalsListViewModel {
        #if TEST
        return GoalsListViewModel(withGoalsRepository: GoalsRepository(withService: goalService,
                                                                       andStore: InMemoryStore()),
                                  activityService: activityService,
                                  andGoalDetailFactory: self)
        #else
        return GoalsListViewModel(withGoalsRepository: goalsRepository,
                           activityService: HKActivityService(),
                           andGoalDetailFactory: self)
        #endif
    }
}

// MARK: GoalDetailViewControllerFactory

protocol GoalDetailViewControllerFactory {
    func makeGoalDetailViewController(withGoal goal: Goal, andActivityReport activityReport: ActivityReport) -> GoalDetailViewController
}

extension AppDependencyContainer: GoalDetailViewControllerFactory {
    
    func makeGoalDetailViewController(withGoal goal: Goal, andActivityReport activityReport: ActivityReport) -> GoalDetailViewController {
        GoalDetailViewController(viewModel: makeGoalDetailViewModel(withGoal: goal, andActivityReport: activityReport))
    }
    
    func makeGoalDetailViewModel(withGoal goal: Goal, andActivityReport activityReport: ActivityReport) -> GoalDetailViewModel {
        GoalDetailViewModel(withGoal: goal, andActivityReport: activityReport)
    }
}

