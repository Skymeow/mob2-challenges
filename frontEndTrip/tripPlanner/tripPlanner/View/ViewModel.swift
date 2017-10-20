//
//  detailView.swift
//  tripPlanner
//
//  Created by Sky Xu on 10/19/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation
import UIKit

ViewModel:

extension ViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // we will configure the cells here
    }
}

