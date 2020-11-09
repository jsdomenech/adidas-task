//
//  URL+setQueryItems.swift
//  adidas-task
//
//  Created by Jaime Domenech on 07/11/2020.
//

import Foundation

extension URL {
    mutating func setQueryItems(_ queryItems: [URLQueryItem]) {
        guard var urlComponents = URLComponents(string: absoluteString),
            queryItems.count > 0 else { return }
        urlComponents.queryItems = queryItems
        if let url = urlComponents.url {
            self = url
        }
    }
}
