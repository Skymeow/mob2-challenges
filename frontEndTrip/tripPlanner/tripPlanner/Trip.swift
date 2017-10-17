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
struct Trip: Decodable, Encodable {
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
