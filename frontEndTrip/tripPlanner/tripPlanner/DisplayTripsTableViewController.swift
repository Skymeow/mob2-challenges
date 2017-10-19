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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

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
//        if eachTrip.trip_name != nil {
            cell.textLabel?.text = eachTrip.trip_name!
            cell.backgroundColor = UIColor.blue
//            cell.detailTextLabel?.text = eachTrip.destination!
//        }
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
