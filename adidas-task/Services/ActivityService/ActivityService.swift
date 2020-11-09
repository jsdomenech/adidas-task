//
//  ActivityService.swift
//  adidas-task
//
//  Created by Jaime Domenech on 07/11/2020.
//

import Foundation

protocol ActivityService {
    
    var authorizationRequested: Bool { get }
    
    func requestForAuthorization(completion: @escaping Callback<Bool>)
    
    func getSteps(completion: @escaping (Int) -> Void)
    func getWalkingDistance(completion: @escaping (Int) -> Void)
    func getRunningDistance(completion: @escaping (Int) -> Void)
    
    func getActivityReport(completion: @escaping (ActivityReport) -> Void)
}

extension ActivityService {
    
    func getActivityReport(completion: @escaping (ActivityReport) -> Void) {
        
        var steps: Int?
        var walkingDistance: Int?
        var runningDistance: Int?
        
        var isProcessCompleted:  Bool { steps != nil && walkingDistance != nil && runningDistance != nil }
        
        var generatedActivityReport: ActivityReport { ActivityReport(stepsCount: steps!,
                                                                     walkingDistance: walkingDistance!,
                                                                     runningDistance: runningDistance!) }
        
        func complete() {
            completion(generatedActivityReport)
        }
        
        getSteps { stepsResult in
            steps = stepsResult
            if isProcessCompleted { complete() }
        }
        
        getWalkingDistance { walkingResult in
            walkingDistance = walkingResult
            if isProcessCompleted { complete() }
        }
        
        getRunningDistance { runningResult in
            runningDistance = runningResult
            if isProcessCompleted { complete() }
        }
    }
}
