//
//  InMemoryStore.swift
//  adidas-task
//
//  Created by Jaime Domenech on 07/11/2020.
//
//  Easy to debug store that keeps the data alive
//  in memory in an array. When you close the app, the array is empty.
//  Also helps to test manualy or with Unit testings.
//

import Foundation

class InMemoryStore: GRStore {
    
    private var goals: [Goal] = []
    
    // MARK: Getters
    
    var isEmpty: Bool { return goals.isEmpty }
    
    func getDailyGoals(completion: @escaping Callback<[Goal]>) {
        debugInfo("[InMemory] getDailyGoals")
        guard !isEmpty else {
            return completion(.failure(GRStoreError.storeIsEmpty))
        }
        completion(.success(goals))
    }
    
    // MARK: Setters
    
    func saveDailyGoals(_ goals: [Goal]) {
        debugInfo("[InMemory] saveDailyGoals: \(goals.count) goals")
        self.goals = goals
    }
}
