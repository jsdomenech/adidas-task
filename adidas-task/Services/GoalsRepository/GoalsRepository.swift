//
//  GoalsRepository.swift
//  adidas-task
//
//  Created by Jaime Domenech on 07/11/2020.
//
//  Repository that encapsulates and simplify working with
//  persistance and networking layer.
//  Just get and set. You don't care if it is comming from
//  an API Request, an Array or CoreData...
//

import Foundation

class GoalsRepository {
    
    private let service: GRService
    private let store: GRStore
    
    init(withService service: GRService, andStore store: GRStore){
        self.service = service
        self.store = store
    }
    
    // MARK: Getters
    
    func getDailyGoals(completion: @escaping Callback<[Goal]>) {
        guard store.isEmpty else {
            return store.getDailyGoals { completion($0) }
        }
        
        service.getDailyGoals { [weak self] result in
            self?.persistIfPossible(result)
            completion(result)
        }
    }
    
    // MARK: Setters
    
    func saveDailyGoals(_ goals: [Goal]) {
        self.store.saveDailyGoals(goals)
    }
    
    
    // MARK: Private Methods
    
    private func persistIfPossible(_ result: Result<[Goal], Error>) {
        guard case .success(let goals) = result else { return }
        self.saveDailyGoals(goals)
    }
}
