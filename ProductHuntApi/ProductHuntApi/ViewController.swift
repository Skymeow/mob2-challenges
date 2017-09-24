//
//  ViewController.swift
//  ProductHuntApi
//
//  Created by Sky Xu on 9/20/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
    @IBOutlet weak var productsTableView: UITableView!
    var post : [Post] = [] {
        didSet{
            DispatchQueue.main.async {
                self.productsTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Networking.netWorking { (products) in
            print(products)
            self.post = products
            DispatchQueue.main.async {
                self.productsTableView.reloadData()
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return post.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let eachPost = post[indexPath.row]
        if eachPost.name != nil {
            cell.textLabel?.text = eachPost.name
            cell.detailTextLabel?.text = eachPost.tagline
//            var nameLabel = UILabel()
//            var taglineLabel = UILabel()
//            nameLabel.text = eachPost.name
//            nameLabel = UILabel(frame: CGRect(self.frame.width - 100, 10, 100.0, 40))
//            cell.addSubview(nameLabel)
//            cell.addSubview(taglineLabel)
//            cell.textLabel?.text = eachPost.name
//
//            cell.textLabel?.text = eachPost.tagline
        }
        
        if eachPost.imageURL == "Yoimage" {
            DispatchQueue.main.async {
                cell.imageView?.image = UIImage(named: "CatImage")
            }
        }
        
            if eachPost.imageURL != "image" {
                DispatchQueue.main.async {
                    cell.imageView?.loadImageUsingCacheWithUrlString(urlString: eachPost.imageURL)
                }
            }
        
        return cell
        
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let posts = post[indexPath.row]
        let postId = posts.id
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let commentsTableVC = storyboard.instantiateViewController(withIdentifier: "CommentsTableViewController") as! CommentsTableViewController
        commentsTableVC.postId = postId
        navigationController?.pushViewController(commentsTableVC, animated: true)
    }
}

