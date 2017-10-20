//
//  DisplayTripsTableViewController.swift
//  tripPlanner
//
//  Created by Sky Xu on 10/17/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class DisplayTripsTableViewController: UITableViewController {
    var user_email: String = ""
    var user_password: String = ""
    
    var trips: [Trip] = []
    {
        didSet{
        }
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        Networking.instance.fetch(route: .trips, method: "GET", headers: ["Authorization": BasicAuth.generateBasicAuthHeader(username: self.user_email, password: self.user_password),"Content-Type": "application/json"], data: nil) { (data, response) in
            let TripsInfo = try? JSONDecoder().decode([Trip].self, from: data)
            guard let allTrips = TripsInfo else {return}
            //            here assign value of alltrips we decode from networking requet to the var trip in the tableview
            self.trips = allTrips
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        }
        
    }



    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return trips.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let eachTrip = trips[indexPath.row]

            cell.textLabel?.text = eachTrip.trip_name!
            cell.backgroundColor = UIColor.blue
            cell.detailTextLabel?.text = eachTrip.destination!
       
        return cell
    }

}
