//
//  Network.swift
//  ProductHuntApi
//
//  Created by Sky Xu on 9/26/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation

class Networkings {
    enum URLname {
        case url1(url:String)
        case url2(url:String)
    }
    func go() {
        switch URLname.self {
        case .url1:
            let url = "https://api.producthunt.com/v1/posts"
        case .url2:
            let url = "https://api.producthunt.com/v1/comments"
        }
    }
    static func netWorking(completion: @escaping ([Post]) -> Void) {
        let session = URLSession.shared
        //        let dg = DispatchGroup()
        
        var url = URL(string: "https://api.producthunt.com/v1/posts")
        let URLParams = [
            "search[featured]": "true",
            "scope": "public",
            "per_page": "10",
            ]
        url = url?.appendingQueryParameters(_parametersDictionary: URLParams)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("api.producthunt.com", forHTTPHeaderField: "HOST")
        request.addValue("__cfduid=d41abb1f526b0a355ab490723eee4f6eb1506097071", forHTTPHeaderField: "Cookie")
        request.addValue("Bearer 15c9794295dbf9fb81bd616505b07f4dfebb5396e8391886f89604abf8170c21", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //        start new task
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                guard let producthunt = try? JSONDecoder().decode(ProductHunt.self, from: data) else {
                    return
                }
                completion(producthunt.posts)
            }
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
    //    formatting the query parameters with an ascii table reference therefore we can return a json file
}


