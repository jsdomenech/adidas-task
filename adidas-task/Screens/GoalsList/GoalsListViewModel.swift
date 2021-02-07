//
//  GoalsListViewModel.swift
//  adidas-task
//
//  Created by Jaime Domenech on 07/11/2020.
//

import UIKit

class GoalsListViewModel {
    
    // MARK: Binders
    
    var navigationHandler: ((UIViewController) -> Void)?
    var reloadTableViewHandler: (([Goal]) -> Void)?
    var showAlertHandler: ((AdidasAlert) -> Void)?
    
    // MARK: Dependencies
    
    private let goalsRepository: GoalsRepository
    private let activityService: ActivityService
    private let goalDetailFactory: GoalDetailViewControllerFactory
    
    // MARK: Properties
    
    var goals = [Goal]()
    var activityReport: ActivityReport?
    
    // MARK: LifeCycle
    
    init(withGoalsRepository goalsRepository: GoalsRepository,
         activityService: ActivityService,
         andGoalDetailFactory goalDetailFactory: GoalDetailViewControllerFactory) {
        
        self.goalsRepository = goalsRepository
        self.activityService = activityService
        self.goalDetailFactory = goalDetailFactory
    }
}

// MARK: Inputs

extension GoalsListViewModel {

    func userDidSelected(_ goal: Goal) {
        guard let activityReport = activityReport else { return }
        navigationHandler?(goalDetailFactory.makeGoalDetailViewController(withGoal: goal,
                                                                          andActivityReport: activityReport))
    }
}

// MARK: Activity Service Authorization

extension GoalsListViewModel {
    
    func askForHealthAuthorization() {
        activityService.requestForAuthorization { [weak self] _ in
            self?.loadActivityReport()
            self?.loadData()
        }
    }
}

// MARK: Data Loaders

extension GoalsListViewModel {
    
    func loadData() {
        self.goalsRepository.getDailyGoals { [weak self] (result) in
            if case .success(let goals) = result {
                debugSuccess("Goals fetched: \(goals.count)")
                self?.goals = goals
                DispatchQueue.main.async {
                    self?.reloadTableViewHandler?(goals)
                }
            } else {
                DispatchQueue.main.async {
                    self?.showAlertHandler?(AdidasAlert.noData)
                }
                debugError("Failed fetching Goals")
            }
        }
        
        if !activityService.authorizationRequested {
            DispatchQueue.main.async { [weak self] in
                self?.showAlertHandler?(AdidasAlert.healthKitAdvisory)
            }
        } else {
            loadActivityReport()
        }
    }
    
    func loadActivityReport() {
        self.activityService.getActivityReport { activityReport in
            debugSuccess(activityReport)
            self.activityReport = activityReport
        }
    }
}
