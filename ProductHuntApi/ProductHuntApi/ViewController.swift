//
//  ViewController.swift
//  ProductHuntApi
//
//  Created by Sky Xu on 9/20/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    var products : Product = [] {
//        didSet{
//
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Networking.netWorking { (products) in
            print(products)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

