//
//  Network.swift
//  ProductHuntApi
//
//  Created by Sky Xu on 9/26/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation

enum Route {
    case post
    case comment(postId: String)
    
//    go to difrent path
//    return exact keyword
    func path()->String{
        switch self {
        case .post:
            return "posts"
        case .comment:
            return "comments"
        }
    }
    
    func headers()->[String: String]{
        return ["Authorization": "Bearer 15c9794295dbf9fb81bd616505b07f4dfebb5396e8391886f89604abf8170c21"]
    }
    
    func urlParameters()->[String: String]{
        switch self {
        case .post:
            return [:]
        case let .comment(postId):
            return ["search[post_id]": postId]
        }
    }
//    the body is request body , it's for post
    func body()->Data? {
        switch self {
        case .post:
            return Data()
        default:
            return nil
        }
    }
//    func model() -> <T> {
//        switch self {
//        case .post:
//            return <[Post]>
//        case .comment:
//            return [Comment]
//        }
//    }
}
class Networking {

    static let instance = Networking()
    var baseUrl = "https://api.producthunt.com/v1/"
    let session = URLSession.shared
    
    func fetch(route: Route, completion: @escaping (Data) -> Void) {
        let fullurlString = baseUrl.appending(route.path())
        var url = URL(string: fullurlString)
        url = url?.appendingQueryParameters(_parametersDictionary: route.urlParameters())
        
        var request = URLRequest(url: url!)
        request.allHTTPHeaderFields = route.headers()
        
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {return}
//                let coder = JSONDecoder()
//            let decodableModel = coder.decode(type(of: Model).self, from: data)
//            completion(decodableModel)
            
            completion(data)
        }
        
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


