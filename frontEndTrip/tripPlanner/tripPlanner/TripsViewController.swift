//
//  TripsViewController.swift
//  tripPlanner
//
//  Created by Sky Xu on 10/16/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class TripsViewController: UIViewController {
    var user_email: String = ""
    var user_password: String = ""
    var completedValue: Bool = false
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var tripName: UITextField!
    
    @IBOutlet weak var startTime: UITextField!
    
    @IBOutlet weak var destination: UITextField!
    
    @IBOutlet weak var waypoint1: UITextField!
    
    @IBOutlet weak var waypoint2: UITextField!
    
    @IBOutlet weak var waypoint3: UITextField!
    
    @IBOutlet weak var waypoint4: UITextField!
    
    
    @IBOutlet weak var switchButton: UISwitch!
    @IBAction func switchIsOn(_ sender: Any) {
        if switchButton.isOn {
            self.completedValue = true
        } else {
            self.completedValue = false
        }
        print(self.completedValue)
    }
    @IBAction func addTripTapped(_ sender: Any) {
        
        var waypointsArr = [Waypoint]()
        let point1 = Waypoint(destination: waypoint1!.text!)
        let point2 = Waypoint(destination: waypoint2!.text!)
        let point3 = Waypoint(destination: waypoint3!.text!)
        let point4 = Waypoint(destination: waypoint4!.text!)
        waypointsArr.append(point1)
        waypointsArr.append(point2)
        waypointsArr.append(point3)
        waypointsArr.append(point4)
        
        let data = Trip(user_id: "userid", completed: self.completedValue, destination: destination!.text!, trip_name: tripName!.text!, start_time: startTime!.text!, waypoints: waypointsArr)
        
        Networking.instance.fetch(route: .trips, method: "POST", headers: ["Authorization": BasicAuth.generateBasicAuthHeader(username: self.user_email, password: self.user_password),"Content-Type": "application/json"], data:data) { (data, response)  in
            print(response)
            if response == 201 {
                print("successed post")
                DispatchQueue.main.async {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let displayTripsTableViewController = storyBoard.instantiateViewController(withIdentifier: "toDisplayTrips") as! DisplayTripsTableViewController
                    displayTripsTableViewController.user_email = self.user_email
                    displayTripsTableViewController.user_password = self.user_password
                    self.present(displayTripsTableViewController, animated: true, completion: nil)
                }
            } else {
                self.addTripTapped(self.postButton)
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
