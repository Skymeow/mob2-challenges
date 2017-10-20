//
//  WaypointsCell.swift
//  tripPlanner
//
//  Created by Sky Xu on 10/19/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation
import UIKit

class WaypointsCell: UITableViewCell {
    let pointLabel = UILable()
    let pointContextLabel = UILable()
    var item: DetailItem? {
        didSet {
            guard let item = item as? DetailWaypointItem else{return}
            pointLabel.text = item.name
            pointContextLabel.text = item.context
        }
    }
}
