//
//  Networking.swift
//  tripPlanner
//
//  Created by Sky Xu on 10/16/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation

enum Route {
    case users
    case trips(user_email: String)
    
    func path()->String {
        switch self {
        case .users:
            return "users"
        case .trips:
            return "trips"
        }
    }
    
//    func headers(username: String, password: String)->[String: String] {
//        return ["Authorization": BasicAuth.generateBasicAuthHeader(username: username, password: password),
//        "Content-Type": "application/json"]
//    }
    
    func urlParameters()->[String: String] {
        switch self {
        case .users:
            return [:]
        case let .trips(user_email):
            return ["user_email": user_email]
        }
    }
    
    func body(data: Encodable)->Data? {
        switch self {
        case .users:
            let encoder = JSONEncoder()
            guard let user = data as? [String: String] else {return nil}
            let result = try? encoder.encode(user)
            return result
        default:
            return nil
        }
    }
}
struct BasicAuth {
    static func generateBasicAuthHeader(username: String, password: String) -> String {
        let loginString = String(format: "%@:%@", username, password)
        let loginData: Data = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString(options: .init(rawValue: 0))
        let authHeaderString = "Basic \(base64LoginString)"
        
        return authHeaderString
    }
}
//typealias JSON = [String: Any]
class Networking {
    static let instance = Networking()
    var baseURL = "http://127.0.0.1:5000/"
    let session = URLSession.shared
    
    func fetch(route: Route, method: String, headers: [String: String], data: Encodable?, completion: @escaping (Data) -> Void) {
        
        let urlString = baseURL.appending(route.path())
        let toUrl = URL(string: urlString)!
        var request = URLRequest(url: toUrl)
      
        request.allHTTPHeaderFields = headers
        request.httpMethod = method
        request.httpBody = route.body(data: data)
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            completion(data)
        }.resume()
        
        
    }
}
