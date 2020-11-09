//
//  GRService.swift
//  adidas-task
//
//  Created by Jaime Domenech on 07/11/2020.
//
//  Goals Repository Service Definition

import Foundation

protocol GRService {
    
    // MARK: Getters
    
    func getDailyGoals(completion: @escaping Callback<[Goal]>)
}
