//
//  JSONLocalStore.swift
//  adidas-task
//
//  Created by Jaime Domenech on 09/11/2020.
//

import Foundation

class JSONLocalStore: GRStore {
    
    private let kPersistantFile = "JSONLocalStore"
    private let persitanceService: PersistanceService
    
    private var goals: [Goal] = []
    
    init(persitanceService: PersistanceService = PersistanceService()) {
        self.persitanceService = persitanceService
        tryToLoadFromJSON()
    }
    
    // MARK: Getters
    
    var isEmpty: Bool { return goals.isEmpty }
    
    func getDailyGoals(completion: @escaping Callback<[Goal]>) {
        debugInfo("[JSONLocalStore] getDailyGoals")
        guard !isEmpty else {
            return completion(.failure(GRStoreError.storeIsEmpty))
        }
        completion(.success(goals))
    }
    
    // MARK: Setters
    
    func saveDailyGoals(_ goals: [Goal]) {
        debugInfo("[JSONLocalStore] saveDailyGoals: \(goals.count) goals")
        self.goals = goals
        tryToSaveInJSON(goals)
    }
}

private extension JSONLocalStore {
    
    func tryToLoadFromJSON() {
        guard let goalsData = try? persitanceService.read(fileNamed: kPersistantFile),
              let decodedGoals = try? JSONDecoder().decode([Goal].self, from: goalsData) else {
            goals = []
            return
        }
        goals = decodedGoals
    }
    
    func tryToSaveInJSON(_ goals: [Goal]) {
        if let data = try? JSONEncoder().encode(goals) {
            try? persitanceService.save(fileNamed: kPersistantFile, data: data)
        }
    }
}
