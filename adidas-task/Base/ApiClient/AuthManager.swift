//
//  AuthManager.swift
//  adidas-task
//
//  Created by Jaime Domenech on 07/11/2020.
//
//  Super simple approach of an AuthManager.
//
//  Our test-app will is not using authentication, but just to show
//  how it could be easily integrated. We can just not provide our implementation
//  and as far as our request doesn't require authentication (requiresAuth == false)
//  this will be ignored.
//
//

import Foundation

protocol AuthManager {
    typealias AuthHeader = (value: String, headerField: String)
    func generateAuthHeader() -> AuthHeader
}
