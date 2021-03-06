
//  AddFriendViewController.swift
//  MoodTracker
//
//  Created by Sky Xu on 9/29/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class AddFriendViewController: UIViewController {

    @IBOutlet weak var friendName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveFriend" {
            var friendModel = Friend(name: friendName.text ?? "", moodContext: "")
//           friendModel.name = friendName.text ?? ""
            let listFriendsTableViewController = segue.destination as! ListFriendsTableViewController

            listFriendsTableViewController.friends.append(friendModel)
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
