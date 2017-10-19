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
    case trips
    
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
        case let .trips:
            return [:]
        }
    }
    
    func body(data: Encodable)->Data? {
        switch self {
        case .users:
            let encoder = JSONEncoder()
            guard let user = data as? User else {return nil}
            let result = try? encoder.encode(user)
            return result
        case .trips:
            let encoder = JSONEncoder()
            guard let trip = data as? Trip else {return nil}
            let result = try? encoder.encode(trip)
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
    
    func fetch(route: Route, method: String, headers: [String: String], data: Encodable?, completion: @escaping (Data, Int) -> Void) {
        
        let urlString = baseURL.appending(route.path())
        var toUrl = URL(string: urlString)!
        toUrl = toUrl.appendingQueryParameters(_parametersDictionary: route.urlParameters())
        var request = URLRequest(url: toUrl)
      
        request.allHTTPHeaderFields = headers
        request.httpMethod = method
        request.httpBody = route.body(data: data)
        session.dataTask(with: request) { (data, response, error) in
            let statusCode: Int = (response as! HTTPURLResponse).statusCode
            guard let data = data else { return }
            completion(data, statusCode)
            
        }.resume()
        
        
    }
}

protocol URLQueryParameterStringConvertible {
    var queryParameters: String {get}
}
//        this property return a query parameters string from the given NSDictionary
extension Dictionary: URLQueryParameterStringConvertible {
    //        this constructor makes whatever assigned to var happen only after the requirements
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                              String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            )
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
}
//append string parameter to url
extension URL {
    func appendingQueryParameters(_parametersDictionary: Dictionary<String, String>) -> URL {
        let URLString: String = String(format: "%@?%@", self.absoluteString, _parametersDictionary.queryParameters)
        return URL(string: URLString)!
    }
}
