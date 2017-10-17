//
//  User.swift
//  tripPlanner
//
//  Created by Sky Xu on 10/16/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation


struct User: Encodable {
    let username: String
    let email: String
    let password: String
    
    init(username: String, email: String, password: String) {
        self.username = username
        self.email = email
        self.password = password
    }
    
}

extension User: Decodable {
    enum Resultkey: String, CodingKey {
        case username
        case email
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Resultkey.self)
        let username = try container.decodeIfPresent(String.self, forKey: .username) ?? "sky"
        let email = try container.decodeIfPresent(String.self, forKey: .email) ?? "sky@gmail.com"
        
        self.init(username: username, email: email, password: "password")
    }
}


