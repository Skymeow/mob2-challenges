//
//  ListFriendsTableViewController.swift
//  MoodTracker
//
//  Created by Sky Xu on 9/28/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit
import CoreData
class Friend {
    var name = ""
    var moodContext = ""
}

protocol PassValueFromDisplay: class {
    func friendMoodSet(moodyFriend: Friend)
}

class ListFriendsTableViewController: UITableViewController, PassValueFromDisplay {
    var friendInMood: Friend?
    
    var friends = [Friend]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    func friendMoodSet(moodyFriend: Friend) {
        self.friendInMood = moodyFriend
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        friends = CoreDataHelper.retrieveFriends()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
//    for delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            CoreDataHelper.delete(friend: friends[indexPath.row])
//            friends = CoreDataHelper.retrieveFriends()
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listfriendsTableViewCell", for: indexPath) as! ListFriendsTableViewCell
        
        let row = indexPath.row
        let friend = friends[row]
        
//        cell.friendTablelabel.text = friendInMood?.name
//        cell.cellMoodLabel.text = friendInMood?.moodContext
        
        cell.friendTablelabel.text = friend.name
        cell.cellMoodLabel.text = friend.moodContext
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "displayMood" {
                print("table view cell tapped")
            let indexPath = tableView.indexPathForSelectedRow!
            let friend = friends[indexPath.row]
            let displayMoodViewController = segue.destination as! DisplayMoodViewController
//            displayMoodViewController.friendModel = friend
        } else if identifier == "addFriend" {
            print("+ button tapped")
           }
        }
    }
//have to define the unwind storyBoardsegue in exit destination VC, so that you can link it in the storyBoard
    @IBAction func unwindToListFriendViewController(_ segue: UIStoryboardSegue) {
//        self.friends = CoreDataHelper.retrieveFriends()
    }


}
