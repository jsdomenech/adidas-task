//
//  HKActivityService.swift
//  adidas-task
//
//  Created by Jaime Domenech on 07/11/2020.
//

import Foundation
import HealthKit
import UIKit

class HKActivityService: ActivityService {
    
    // MARK: Properties
    
    private let date: Date = Calendar.current.startOfDay(for: Date())
    private let healthStore: HKHealthStore
    
    // MARK: LifeCycle
    
    init() {
        self.healthStore = HKHealthStore()
    }
    
    // MARK: ActivityService Conformance
    
    private (set) lazy var authorizationRequested: Bool = getAuthorizationRequestedFromUserDefaults() {
        didSet { setAuthorizationRequested(authorizationRequested) }
    }
    
    
    func getSteps(completion: @escaping (Int) -> Void) {
        getHKSteps(for: date) { completion($0) }
    }
    
    func getWalkingDistance(completion: @escaping (Int) -> Void) {
        getHKWalkingDistance(for: date) { completion($0) }
    }
    
    func getRunningDistance(completion: @escaping (Int) -> Void) {
        getHKRunningDistance(for: date) { completion($0) }
    }
    
    func requestForAuthorization(completion: @escaping Callback<Bool>) {
        self._requestForAuthorization(completion: completion)
    }
}

// MARK: HealthKit Logic

private extension HKActivityService {
    
    enum HKActivityServiceError: Error {
        case unknownErrorWhileAuthorizing
        case notAvailableOnDevice
        case notAuthorized
    }
    
    var stepsIdentifier: HKQuantityTypeIdentifier { .stepCount }
    var distanceWalkingIdentifier: HKQuantityTypeIdentifier { .distanceWalkingRunning }
    var workoutRunningType: HKWorkoutActivityType { .running }
    
    func _requestForAuthorization(completion: @escaping Callback<Bool>) {
        
        guard HKHealthStore.isHealthDataAvailable() else {
            return completion(.failure(HKActivityServiceError.notAvailableOnDevice))
        }
        
        let typesToRead = Set<HKSampleType>([HKObjectType.quantityType(forIdentifier: stepsIdentifier),
                                             HKObjectType.quantityType(forIdentifier: distanceWalkingIdentifier),
                                             HKObjectType.workoutType()].compactMap { $0 })
        
        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { [weak self] (success, error) in
            self?.authorizationRequested = success
            if success { completion(.success(true)) }
            else if let error = error { completion(.failure(error)) }
            else { completion(.failure(HKActivityServiceError.unknownErrorWhileAuthorizing)) }
        }
    }
    
    func getHKSteps(for date: Date, completion: @escaping (Int) -> Void) {
        guard let stepsQuantityType = HKObjectType.quantityType(forIdentifier: stepsIdentifier) else { return }
        let now = Date()
        let predicate = HKQuery.predicateForSamples(withStart: date, end: now, options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: stepsQuantityType,
                                      quantitySamplePredicate: predicate,
                                      options: .cumulativeSum) { query, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                if let error = error {
                    debugError("HK-Steps: 0, \(error.localizedDescription)")
                }
                return completion(0)
            }
            let steps = Int(sum.doubleValue(for: HKUnit.count()))
            debugSuccess("HK-Steps: \(steps)")
            completion(steps)
            
        }
        healthStore.execute(query)
    }
    
    func getHKRunningDistance(for date: Date, completion: @escaping (Int) -> Void) {
        let now = Date()
        let workoutPredicate = HKQuery.predicateForWorkouts(with: workoutRunningType)
        let datePredicate = HKQuery.predicateForSamples(withStart: date, end: now, options: .strictStartDate)
        
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [workoutPredicate, datePredicate])
        let query = HKSampleQuery(sampleType: .workoutType(), predicate: predicate, limit: 0, sortDescriptors: nil) { query, results, error in
            guard let results = results else {
                if let error = error {
                    debugError("HK-Running: 0, \(error.localizedDescription)")
                }
                return completion(0)
            }
            let runningDistance = results.compactMap { $0 as? HKWorkout }
                                            .compactMap { $0.totalDistance }
                                            .map { Int($0.doubleValue(for: HKUnit.meter())) }
                                            .reduce(0, +)
            debugSuccess("HK-RunningDistance: \(runningDistance)")
            completion(runningDistance)
        }
        healthStore.execute(query)
    }
    
    func getHKWalkingDistance(for date: Date, completion: @escaping (Int) -> Void) {
        guard let walkingQuantityType = HKObjectType.quantityType(forIdentifier: distanceWalkingIdentifier) else { return }
        let now = Date()
        let predicate = HKQuery.predicateForSamples(withStart: date, end: now, options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: walkingQuantityType,
                                      quantitySamplePredicate: predicate,
                                      options: .cumulativeSum) { query, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                if let error = error {
                    debugError("HK-WalkingDistance: 0, \(error.localizedDescription)")
                }
                return completion(0)
            }
            let walkingDistance = Int(sum.doubleValue(for: HKUnit.meter()))
            debugSuccess("HK-WalkingDistance: \(walkingDistance)")
            completion(walkingDistance)
            
        }
        healthStore.execute(query)
    }
}

// MARK: UserDefaults Logic

private extension HKActivityService {
    
    var kUserDefaultsHKAuthorizationKey: String { "UserDefaultsHKAuthorizationKey" }
    
    func getAuthorizationRequestedFromUserDefaults() -> Bool {
        UserDefaults.standard.bool(forKey: kUserDefaultsHKAuthorizationKey)
    }
    
    func setAuthorizationRequested(_ requested: Bool) {
        UserDefaults.standard.set(true, forKey: kUserDefaultsHKAuthorizationKey)
    }
}
