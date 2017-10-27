//
//  TestChoice.swift
//  tripPlanner
//
//  Created by Sky Xu on 10/22/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation
import UIKit
class PickViewController: UIViewController {
    var user_email: String = ""
    var user_password: String = ""
    
    
    @IBAction func seeButtonTapped(_ sender: Any) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "toSeePage", sender: nil)
        }
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let tripsViewController = storyBoard.instantiateViewController(withIdentifier: "totrips") as! TripsViewController
//        tripsViewController.user_email = self.user_email
//        tripsViewController.user_password = self.user_password
//        self.present(tripsViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func postButtonTapped(_ sender: Any) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "toPostPage", sender: nil)
        }
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let tripsViewController = storyBoard.instantiateViewController(withIdentifier: "totrips") as! TripsViewController
//        tripsViewController.user_email = self.user_email
//        tripsViewController.user_password = self.user_password
//        self.present(tripsViewController, animated: true, completion: nil)
    }
    
    //    @IBAction func postTrips(_ sender: Any) {
    //        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    //        let tripsViewController = storyBoard.instantiateViewController(withIdentifier: "totrips") as! TripsViewController
    //        tripsViewController.user_email = self.user_email
    //        tripsViewController.user_password = self.user_password
    //        self.present(tripsViewController, animated: true, completion: nil)
    //    }
    //
    //
    //    @IBAction func seeTrips(_ sender: Any) {
    //        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    //        let displayTripsTableViewController = storyBoard.instantiateViewController(withIdentifier: "todisplaytrips") as! DisplayTripsTableViewController
    //        displayTripsTableViewController.user_email = self.user_email
    //        displayTripsTableViewController.user_password = self.user_password
    //        self.present(displayTripsTableViewController, animated: true, completion: nil)
    //    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
