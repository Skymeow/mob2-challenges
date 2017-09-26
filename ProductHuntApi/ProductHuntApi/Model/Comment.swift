//
//  Comment.swift
//  ProductHuntApi
//
//  Created by Sky Xu on 9/23/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation

struct Comments: Decodable {
    let comments: [Comment]
}

struct Comment {
    var body: String
}

extension Comment: Decodable {
    enum SearchKey: String, CodingKey {
        case body
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SearchKey.self)
        let body = try container.decode(String.self, forKey: .body) ?? "Yobody"
        self.init(body: body)
    }
}

class Network {
    static func networking(postId: Int, completion: @escaping ([Comment]) -> Void) {
//        let session = URLSession.shared
        var url = URL(string: "https://api.producthunt.com/v1/comments")
        let date = Date()
        let urlParams = ["search[post_id]": String(postId),
                         "scope": "public",
                         "created_at": String(describing: date),
                         "per_page": "20"]
        url = url?.appendingQueryParameters(_parametersDictionary: urlParams)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("api.producthunt.com", forHTTPHeaderField: "HOST")
        request.addValue("__cfduid=d41abb1f526b0a355ab490723eee4f6eb1506097071", forHTTPHeaderField: "Cookie")
        request.addValue("Bearer 15c9794295dbf9fb81bd616505b07f4dfebb5396e8391886f89604abf8170c21", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        Singleton.sharedSession.dataTask(with: request) {(data, response, error) in
            if let data = data {
                guard let commentList = try? JSONDecoder().decode(Comments.self, from: data) else { return }
                completion(commentList.comments)
            }
        }.resume()
    }
}











