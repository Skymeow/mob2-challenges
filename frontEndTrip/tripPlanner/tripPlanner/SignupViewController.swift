//
//  ViewController.swift
//  tripPlanner
//
//  Created by Sky Xu on 10/15/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

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
        
        let nameInput = UITextField(frame: CGRect(x: 150, y: 100, width: width2, height: height))
        self.view.addSubview(nameInput)
        nameInput.placeholder = "type in your username"
        
        let emailInput = UITextField(frame: CGRect(x: 150, y: 200, width: width2, height: height))
        self.view.addSubview(emailInput)
        emailInput.placeholder = "type in your email"
        
        let passwordInput = UITextField(frame: CGRect(x: 150, y: 300, width: width2, height: height))
        self.view.addSubview(passwordInput)
        passwordInput.placeholder = "type in your password"
        
        let username = nameInput.text
        let email = emailInput.text
        let password = passwordInput.text
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

