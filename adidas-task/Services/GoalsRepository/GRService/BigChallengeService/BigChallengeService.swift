//
//  BigChallengeService.swift
//  adidas-task
//
//  Created by Jaime Domenech on 07/11/2020.
//

import Foundation

class BigChallengeService: APIClient, GRService {
    
    // MARK: API Client Properties
    
    let session: URLSession = URLSession.shared
    let baseURL: URL = URL(string: Statics.kBigChallengeURL)!
    let authManager: AuthManager? = nil
    
    // MARK: GRService
    
    func getDailyGoals(completion: @escaping Callback<[Goal]>) {
        self.send(BigChallengeRequests.GetGoals()) { result in
            switch result {
            case .success(let response):
                completion(.success(response.items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
