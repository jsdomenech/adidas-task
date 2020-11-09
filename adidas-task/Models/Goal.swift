//
//  Goal.swift
//  adidas-task
//
//  Created by Jaime Domenech on 07/11/2020.
//

import Foundation

struct Goal: Codable {
    let id: String
    let title: String
    let description: String
    let type: String
    let goal: Int
    let reward: Reward
}

// MARK: Computed GoalType as Enum

import UIKit

extension Goal {
    
    var goalType: GoalType { return GoalType(rawValue: type) ?? .other }
    
    enum GoalType: String {
        case step = "step"
        case walking = "walking_distance"
        case running = "running_distance"
        case other = "other"
        
        func asText() -> String {
            switch self {
            case .step:
                return NSLocalizedString("stepsTitle", comment: "")
            case .walking:
                return NSLocalizedString("walkingTitle", comment: "")
            case .running:
                return NSLocalizedString("runTitle", comment: "")
            case .other:
                return NSLocalizedString("otherTitle", comment: "")
            }
        }
        
        func relatedImage() -> UIImage {
            switch self {
            case .step:
                return #imageLiteral(resourceName: "steps")
            case .walking:
                return #imageLiteral(resourceName: "walk")
            case .running:
                return #imageLiteral(resourceName: "run")
            case .other:
                return #imageLiteral(resourceName: "steps")
            }
        }
        
        func relatedColor() -> UIColor {
            switch self {
            case .step:
                return .stepsAdidas
            case .walking:
                return .walkAdidas
            case .running:
                return .runAdidas
            case .other:
                return .stepsAdidas
            }
        }
        
        func activityAmount(for activityReport: ActivityReport) -> Int {
            switch self {
            case .step:
                return activityReport.stepsCount
            case .walking:
                return activityReport.walkingDistance
            case .running:
                return activityReport.runningDistance
            case .other:
                return 0
            }
        }
    }
}
