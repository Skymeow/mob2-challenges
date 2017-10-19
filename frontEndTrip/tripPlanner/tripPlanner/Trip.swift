//
//  Trip.swift
//  tripPlanner
//
//  Created by Sky Xu on 10/16/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation
import UIKit

struct Waypoint: Codable {
    let destination: String?
}

//struct Waypoints: Codable {
//    let points: [Waypoint]
//}

struct Trip: Codable {
    let user_id: String?
    let completed: Bool?
    let destination: String?
    let trip_name: String?
    let start_time: String?
    let waypoints: [Waypoint]
    
}

//struct ArrayTrips: Decodable, Encodable {
//    let trips: [Trip]
//}
//
//extension Trip {
//    enum ResultKeys: String, CodingKey {
//        case user_id
//        case completed
//        case destination
//        case trip_name
//        case start_time
//        case waypoints
//    }
////
////    enum secondLayerKey: String, CodingKey {
////        case destination
////    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: ResultKeys.self)
//        let user_id = try container.decodeIfPresent(String.self, forKey: .user_id)
//        let completed = try container.decodeIfPresent(Bool.self, forKey: .completed)
//        let destination = try container.decodeIfPresent(String.self, forKey: .destination) ?? "yo"
//        let trip_name = try container.decodeIfPresent(String.self, forKey: .trip_name) ?? "unknowntrip"
//        let start_time = try container.decodeIfPresent(String.self, forKey: .start_time) ?? "yo"
////        let waypointsContainer = try container.nestedContainer(keyedBy: secondLayerKey.self, forKey: .waypoints)
//        var waypoints = try container.decodeIfPresent(Waypoints.self, forKey: .waypoints)
//
////        var waypointsInfo = JSONDecoder().decode(Waypoints.self, from: waypoints)
////        var points = waypointsInfo.points
//
//        self.init(user_id: user_id, completed: completed, destination: destination, trip_name: trip_name, start_time: start_time, waypoints: waypoints)
//
//    }
//}








