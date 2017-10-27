//
//  DisplayTripsTableViewController.swift
//  tripPlanner
//
//  Created by Sky Xu on 10/17/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation
import UIKit
import KeychainSwift

class DisplayTripsTableViewController: UITableViewController {
//    var user_email: String = ""
//    var user_password: String = ""
    
    var trips: [Trip] = [] {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let keychain = KeychainSwift()
        let authToken = keychain.get("authTokenKey")
        Networking.instance.fetch(route: .trips, method: "GET", headers: ["Authorization": authToken!,"Content-Type": "application/json"], data: nil) { (data, response) in
            print(response)
            let TripsInfo = try? JSONDecoder().decode([Trip].self, from: data)
            guard let allTrips = TripsInfo else {return}
            //            here assign value of alltrips we decode from networking requet to the var trip in the tableview
            self.trips = allTrips
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return trips.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
            let eachTrip = trips[indexPath.row]
            cell.textLabel?.text = eachTrip.trip_name!
            cell.backgroundColor = UIColor.blue
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier2", for: indexPath)
            let eachTrip = trips[indexPath.row]
            cell.textLabel?.text = "\(eachTrip.completed!)"
            cell.backgroundColor = UIColor.red
            return cell
        default:
            fatalError("Error: unexpected index path")
        }
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "tryToSeepage" {
//            let vc = segue.destination as! LoginViewController
//            //            vc.delegate = self
////            vc.callBack  = self.
//            
//        }
//        
//    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "backToLogin" {
//            print("yo we here")
//            let vc = segue.destination as! LoginViewController
//            vc.delegate = self
//
//        }
//
//    }
    
    
    
}
