//
//  DisplayMoodViewController.swift
//  MoodTracker
//
//  Created by Sky Xu on 9/28/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit


class DisplayMoodViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var friendInMood: Friend?
//    we use friendModel here to edit the friend info inside ListfriendVC
//    public var friendModel: Friend?
    
    var row: Int? 
   
    weak var delegate: PassValueFromDisplay?
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var pickerMood: UIPickerView!
    let emoji = ["😀", "😒", "😞","😰"]
    func numberOfComponents(in pickerMood: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerMood: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        return emoji[row]
    }
    
    func pickerView(_ pickerMood: UIPickerView, numberOfRowsInComponent component: Int)->Int{
        return emoji.count
    }
    
    func pickerView(_ pickerMood: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        moodLabel.text = emoji[row]
        friendInMood?.moodContext = emoji[row]
        delegate?.friendMoodSet(moodyFriend: self.friendInMood!, row: self.row!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "save" {
            self.friendInMood!.moodContext = moodLabel.text ?? ""
            let listFriendTableViewController = segue.destination as! ListFriendsTableViewController
  
        }
    }

}
