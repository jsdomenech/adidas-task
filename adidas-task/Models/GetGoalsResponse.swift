//
//  GetGoalsResponse.swift
//  adidas-task
//
//  Created by Jaime Domenech on 07/11/2020.
//

import Foundation

struct GetGoalsResponse: Codable {
    let items: [Goal]
    let nextPageToken: String
}
