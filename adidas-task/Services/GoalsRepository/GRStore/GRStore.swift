//
//  GRStore.swift
//  adidas-task
//
//  Created by Jaime Domenech on 07/11/2020.
//
//  Goals Repository Store Definition

protocol GRStore {
    
    // MARK: Getters
    
    var isEmpty: Bool { get }
    
    func getDailyGoals(completion: @escaping Callback<[Goal]>)
    
    // MARK: Setters
    
    func saveDailyGoals(_ goals: [Goal])
}
