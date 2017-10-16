//
//  ViewController.swift
//  tripPlanner
//
//  Created by Sky Xu on 10/15/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    var username: String!
    var email: String!
    var password: String!
    let width = 0.25 * UIScreen.main.bounds.size.width
    let height = 0.15 * UIScreen.main.bounds.size.height
    let width2 = 0.5 * UIScreen.main.bounds.size.width
    
    let nameInput = UITextField(
        frame: CGRect(x: 150, y: 100, width: 0.5*UIScreen.main.bounds.size.width, height: 0.15*UIScreen.main.bounds.size.height)
    )
    
    let emailInput = UITextField(frame: CGRect(x: 150, y: 200, width: 0.5*UIScreen.main.bounds.size.width, height: 0.15*UIScreen.main.bounds.size.height))
    
    let passwordInput = UITextField(frame: CGRect(x: 150, y: 300, width: 0.5*UIScreen.main.bounds.size.width, height: 0.15*UIScreen.main.bounds.size.height))
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let width = 0.25*UIScreen.main.bounds.size.width
        let height = 0.15*UIScreen.main.bounds.size.height
        let width2 = 0.5*UIScreen.main.bounds.size.width
        let nameLabel = UILabel(frame: CGRect(x: 20, y: 100, width: width, height: height))
        self.view.addSubview(nameLabel)
        nameLabel.text = "Username"
        nameLabel.textAlignment = .left
        
        let emailLabel = UILabel(frame: CGRect(x: 20, y: 200, width: width, height: height))
        self.view.addSubview(emailLabel)
        emailLabel.text = "Email"
        emailLabel.textAlignment = .left
        
        let passwordLabel = UILabel(frame: CGRect(x: 20, y: 300, width: width, height: height))
        self.view.addSubview(passwordLabel)
        passwordLabel.text = "Password"
        passwordLabel.textAlignment = .left
        

        self.view.addSubview(nameInput)
        nameInput.placeholder = "type in your username"
        
      
        self.view.addSubview(emailInput)
        emailInput.placeholder = "type in your email"
        
        
        self.view.addSubview(passwordInput)
        passwordInput.placeholder = "type in your password"
        
//        self.username = nameInput.text
//        self.email = emailInput.text
//        self.password = passwordInput.text
        
    }
    @IBAction func signupTapped(_ sender: Any) {
        print("sign up tapped")
        self.username = self.nameInput.text
        self.email = self.emailInput.text
        self.password = self.passwordInput.text
        Networking.instance.post(username:username, email:email, password:password){(data) in
            print(data)

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

