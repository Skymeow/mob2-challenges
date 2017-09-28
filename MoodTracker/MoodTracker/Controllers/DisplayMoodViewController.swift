//
//  DisplayMoodViewController.swift
//  MoodTracker
//
//  Created by Sky Xu on 9/28/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class DisplayMoodViewController: UIViewController {
    var friend: Friend?
    @IBOutlet weak var friendContentTextView: UITextField!
    @IBOutlet weak var pickerMood: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       friendContentTextView.text = friend?.title ?? ""
//        pickerMood.text = friend.mood ?? ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "save" {
//            let friend = self.friend ?? CoreDataHelper.newFriend()
//            friend.title = friendContentTextView.text ?? ""
//            friend.mood = pickerMood.text ?? ""
//            CoreDataHelper.saveFriend()
        }
    }

}
