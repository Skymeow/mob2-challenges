//
//  Networking.swift
//  tripPlanner
//
//  Created by Sky Xu on 10/16/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation
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
    var baseURL = "http://127.0.0.1:5000/users"
    let session = URLSession.shared
    
    func post(username:String, email:String, password:String, completion: @escaping (User?) -> Void) {
        let url = URL(string: self.baseURL)
        var request = URLRequest(url: url!)
        let jsonDict = ["email": email,
                              "username": username,
                              "password": password
        ]
        
        let encoder = JSONEncoder()
        let jsonData = try? encoder.encode(jsonDict)
        
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
    
//        request.setValue(BasicAuth.generateBasicAuthHeader(username: email, password: password), forHTTPHeaderField: "Authorization")
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {return}
                print(json)
                completion(nil)
            }
        }.resume()
        
        
    }
}
