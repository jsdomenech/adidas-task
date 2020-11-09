//
//  URLRequest+addAuthHeader.swift
//  adidas-task
//
//  Created by Jaime Domenech on 07/11/2020.
//

import Foundation

extension URLRequest {
    mutating func addAuthHeader(with authManager: AuthManager){
        let header = authManager.generateAuthHeader()
        self.setValue(header.value, forHTTPHeaderField: header.headerField)
    }
}
