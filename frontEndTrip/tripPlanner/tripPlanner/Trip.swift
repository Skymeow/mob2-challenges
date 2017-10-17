//
//  Trip.swift
//  tripPlanner
//
//  Created by Sky Xu on 10/16/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation
import UIKit

struct Waypoint: Decodable, Encodable {
    let destination: String?
    
    init(destination: String?) {
        self.destination = destination
    }
}
struct Trip: Encodable {
    let user_email: String?
    let completed: Bool?
    let destination: String?
    let trip_name: String?
    let start_time: String?
    let waypoints: [Waypoint]
    
    init(user_email: String?, completed: Bool?, destination: String?, trip_name: String?, start_time: String?, waypoints: [Waypoint]? ) {
        self.user_email = user_email
        self.completed = completed
        self.destination = destination
        self.trip_name = trip_name
        self.start_time = start_time
        self.waypoints = waypoints!
    }
    
}

struct ArrayTrips: Decodable {
    let trips: [Trip]
}

extension Trip: Decodable {
    enum ResultKeys: String, CodingKey {
        case user_email
        case completed
        case destination
        case trip_name
        case start_time
        case waypoints
    }
//
//    enum secondLayerKey: String, CodingKey {
//        case destination
//    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResultKeys.self)
        let user_email = try container.decodeIfPresent(String.self, forKey: .user_email)
        let completed = try container.decodeIfPresent(Bool.self, forKey: .completed)
        let destination = try container.decodeIfPresent(String.self, forKey: .destination)
        let trip_name = try container.decodeIfPresent(String.self, forKey: .trip_name)
        let start_time = try container.decodeIfPresent(String.self, forKey: .start_time)
//        let waypointsContainer = try container.nestedContainer(keyedBy: secondLayerKey.self, forKey: .waypoints)
        let waypoints = try container.decodeIfPresent([Waypoint].self, forKey: .waypoints)
        self.init(user_email: user_email, completed: completed, destination: destination, trip_name: trip_name, start_time: start_time, waypoints: waypoints)
        
    }
}








