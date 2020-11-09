//
//  BigChallengeRequests.swift
//  adidas-task
//
//  Created by Jaime Domenech on 07/11/2020.
//

import Foundation

struct BigChallengeRequests {}

// MARK: Get Goals

extension BigChallengeRequests {
    
    struct GetGoals: APIRequest {
        
        typealias Response  = GetGoalsResponse
        typealias Body      = String
        
        var method: HTTPMethod          = .GET
        var resource: String            = "goals"
        var contentType: ContentType    = .none
        var body: Body?                 = nil
        var queryItems: [URLQueryItem]  = []
        var requiresAuth: Bool          = false
    }
}
