//
//  LoginViewController.swift
//  tripPlanner
//
//  Created by Sky Xu on 10/16/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation
import UIKit

struct Alerts {
    func loginError( controller: LoginViewController) {
        let logInAlert = UIAlertController(title: "Login error", message: "plz try again", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "try again", style: .default, handler: nil)
        logInAlert.addAction(cancel)
        controller.present(logInAlert, animated: true, completion: nil)
    }
}

class LoginViewController: UIViewController {
    var user_email: String = ""
    var user_password: String = ""
    let alert = Alerts()
    var email: String!
    var password: String!
    let width = 0.25 * UIScreen.main.bounds.size.width
    let height = 0.15 * UIScreen.main.bounds.size.height
    let width2 = 0.5 * UIScreen.main.bounds.size.width
    
    let emailInput = UITextField(frame: CGRect(x: 150, y: 200, width: 0.5*UIScreen.main.bounds.size.width, height: 0.15*UIScreen.main.bounds.size.height))
    
    let passwordInput = UITextField(frame: CGRect(x: 150, y: 300, width: 0.5*UIScreen.main.bounds.size.width, height: 0.15*UIScreen.main.bounds.size.height))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = 0.25*UIScreen.main.bounds.size.width
        let height = 0.15*UIScreen.main.bounds.size.height
        let width2 = 0.5*UIScreen.main.bounds.size.width
        
        let emailLabel = UILabel(frame: CGRect(x: 20, y: 200, width: width, height: height))
        self.view.addSubview(emailLabel)
        emailLabel.text = "Email"
        emailLabel.textAlignment = .left
        
        let passwordLabel = UILabel(frame: CGRect(x: 20, y: 300, width: width, height: height))
        self.view.addSubview(passwordLabel)
        passwordLabel.text = "Password"
        passwordLabel.textAlignment = .left
        
        self.view.addSubview(emailInput)
        emailInput.placeholder = "type in your email"
        
        
        self.view.addSubview(passwordInput)
        passwordInput.placeholder = "type in your password"
    }
    @IBAction func loginTapped(_ sender: Any) {
        print("login tapped")
        self.user_email = self.emailInput.text!
        self.user_password = self.passwordInput.text!
        
        Networking.instance.fetch(route: Route.users, method: "GET", headers: ["Authorization": BasicAuth.generateBasicAuthHeader(username: self.user_email, password: self.user_password),"Content-Type": "application/json"], data: nil) { (data, response) in
            print(data,response)
//            guard let userInfo = try? JSONDecoder().decode(User.self, from: data) else {return}
//            print(userInfo)
//            self.user_email = userInfo.email

            if response == 200 {
                print("successed login")
                DispatchQueue.main.async {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                    let tripsViewController = storyBoard.instantiateViewController(withIdentifier: "toTrips") as! TripsViewController
//                    tripsViewController.user_email = self.user_email
//                    tripsViewController.user_password = self.user_password
//                    self.present(tripsViewController, animated: true, completion: nil)
                    let displayTripsTableViewController = storyBoard.instantiateViewController(withIdentifier: "toDisplayTrips") as! DisplayTripsTableViewController
                    displayTripsTableViewController.user_email = self.user_email
                    displayTripsTableViewController.user_password = self.user_password
                    self.present(displayTripsTableViewController, animated: true, completion: nil)
                }
            } else {
                 DispatchQueue.main.async {
                   self.alert.loginError(controller: self)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


