//
//  ProfileViewController.swift
//  Tweeter
//
//  Created by Jehan Tremback on 3/1/15.
//  Copyright (c) 2015 Jehan Tremback. All rights reserved.
//

import UIKit

class ProfileViewController: HomeViewController {
//    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
//    var tweets: [Tweet]?
    
    override func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath
    ) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCellWithIdentifier(
                "HomeTableViewCell"
            ) as HomeTableViewCell
            
            if let tweets = self.tweets {
                cell.populate(self.tweets![indexPath.row - 1])
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(
                "ProfileTableViewCell"
            ) as ProfileTableViewCell
            
            if let tweets = self.tweets {
                cell.populate(self.tweets![indexPath.row - 1])
            }
            
            return cell
        }
    }
    
    override func tableView(
        tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        println("section: \(section)")
        if let tweets = self.tweets {
            println("tweets count \(tweets.count)")
            return tweets.count + 1
        } else {
            return 0
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
