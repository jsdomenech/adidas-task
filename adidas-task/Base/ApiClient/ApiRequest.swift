//
//  ApiRequest.swift
//  adidas-task
//
//  Created by Jaime Domenech on 07/11/2020.
//
//  Type that represents a Request to make easier
//  and safer to create requests.
//

import Foundation


// A type for request used in application
protocol APIRequest {
    
    associatedtype Response: Decodable
    
    // An encodabale type that will be send in httpBody with request.
    associatedtype Body: Encodable
    
    // A type of request httpMethod
    var method: HTTPMethod { get }
    
    // A value that contain relative path for request destination.
    var resource: String { get }
    
    // A content type in HTTP body send as HTTP header
    var contentType: ContentType { get }
    
    // An QueryItems Array to send as queryItems in the request
    var queryItems: [URLQueryItem] { get }
    
    // A value to indicate if needs to be added an Auth header.
    var requiresAuth: Bool { get }
    
    // A value that contains encodable object to send within request httpBody
    var body: Body? { get }
}


enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum ContentType: String {
    case json = "application/json"
    case none
    // We could define more types here:
    // **Example:**
    //
    //    case formURLEncoded = "application/x-www-form-urlencoded"
}
