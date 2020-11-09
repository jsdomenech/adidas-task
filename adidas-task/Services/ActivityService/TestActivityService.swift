//
//  TestActivityService.swift
//  adidas-task
//
//  Created by Jaime Domenech on 08/11/2020.
//

import Foundation

class TestActivityService: ActivityService {
    
    var onRequestForAuthorization: (()->Void)?
    
    var mockSteps: Int = 10
    var mockWalking: Int = 100
    var mockRunning: Int = 1000
        
    var authorizationRequested: Bool = true
    
    func requestForAuthorization(completion: @escaping Callback<Bool>) {
        onRequestForAuthorization?()
        completion(.success(true))
    }
    
    func getSteps(completion: @escaping (Int) -> Void) {
        completion(mockSteps)
    }
    
    func getWalkingDistance(completion: @escaping (Int) -> Void) {
        completion(mockWalking)
    }
    
    func getRunningDistance(completion: @escaping (Int) -> Void) {
        completion(mockRunning)
    }
    
    
    
}
