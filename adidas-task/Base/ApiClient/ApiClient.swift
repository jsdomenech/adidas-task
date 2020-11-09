//
//  ApiClient.swift
//  adidas-task
//
//  Created by Jaime Domenech on 07/11/2020.
//

import Foundation


/// A type representing an APIClient used in Application.
protocol APIClient {
    /// Session used by API Client.
    var session: URLSession { get }
    
    /// A value that helps convert relative paths from APIRequest to absolute path of a resource.
    var baseURL: URL { get }
    
    /// Headers generator for secure Requests
    var authManager: AuthManager? { get }
    
    @discardableResult
    func send<T: APIRequest>(
        _ request: T,
        completion: @escaping Callback<T.Response>) -> URLSessionDataTask
}

extension APIClient {
    @discardableResult
    func send<T: APIRequest>(_ request: T,
                             completion: @escaping Callback<T.Response>) -> URLSessionDataTask {
        
        let endpoint = self.endpoint(for: request)
        let task = session.dataTask(with: endpoint) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(APIClientError.notHTTPResponse))
                return
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                if let data = data, let serverError = try? JSONDecoder().decode(ServerError.self, from: data){
                    completion(.failure(APIClientError.server(message: serverError.descriptionMessage)))
                }else {
                    completion(.failure(APIClientError.badHTTPResponse(statusCode: httpResponse.statusCode)))
                }
                return
            }
            guard let data = data else {
                completion(.failure(APIClientError.notDataRetrieved))
                return
            }
            
            if let result = try? JSONDecoder().decode(T.Response.self, from: data) {
                completion(.success(result))
            }else {
                completion(.failure(APIClientError.decoding))
            }
        }
        
        task.resume()
        
        return task
    }

    private func endpoint<T: APIRequest>(for request: T) -> URLRequest {
        guard var baseURL = URL(string: request.resource, relativeTo: baseURL) else {
            fatalError("Bad Resource: \(request.resource)")
        }
        
        baseURL.setQueryItems(request.queryItems)
        
        var urlRequest = URLRequest(url: baseURL)
        urlRequest.httpMethod = request.method.rawValue
        
        if request.contentType != .none {
            urlRequest.addValue(request.contentType.rawValue, forHTTPHeaderField: "Content-Type")
        }
        
        if let manager = authManager, request.requiresAuth {
            urlRequest.addAuthHeader(with: manager)
        }
        
        debugInfo("[ApiClient] Request: `\(urlRequest.httpMethod ?? "_NULL_") \(urlRequest.url?.relativeString ?? "_NULL_")`")
        return urlRequest
    }
}

/// An error value that can be thrown by APIClient.
enum APIClientError: Error {
    case decoding
    case notHTTPResponse
    case badHTTPResponse(statusCode: Int)
    case notDataRetrieved
    case server(message: String)
}

struct ServerError: Decodable {
    let error: String
    let message: String
    var descriptionMessage: String { return "\(error): \(message)"}
}
