//
//  ChoiceViewController.swift
//  tripPlanner
//
//  Created by Sky Xu on 10/21/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class ChoiceViewController: UIViewController {
    var user_email: String = ""
    var user_password: String = ""
    
    @IBAction func postTrips(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tripsViewController = storyBoard.instantiateViewController(withIdentifier: "toTrips") as! TripsViewController
        tripsViewController.user_email = self.user_email
        tripsViewController.user_password = self.user_password
        self.present(tripsViewController, animated: true, completion: nil)
    }
    
    @IBAction func seeTrips(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let displayTripsTableViewController = storyBoard.instantiateViewController(withIdentifier: "toDisplayTrips") as! DisplayTripsTableViewController
        displayTripsTableViewController.user_email = self.user_email
        displayTripsTableViewController.user_password = self.user_password
        self.present(displayTripsTableViewController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
