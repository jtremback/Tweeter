//
//  HomeViewController.swift
//  Tweeter
//
//  Created by Jehan Tremback on 2/19/15.
//  Copyright (c) 2015 Jehan Tremback. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

//    @IBAction func signOutAction(sender: AnyObject) {
//        User.currentUser = nil
//        self.performSegueWithIdentifier("logoutSegue", sender: self)
//    }
//    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    var tweets: [Tweet]?
    var user: User?
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        tableView.hidden = true
        
        navigationItem.title = "Profile"
    }

    func populate (user: AnyObject) {
        self.user = user as? User
        getTweets()
    }

    func getTweets () {
        TwitterClient.sharedInstance.getTweetsForUser(self.user?.user_id, completion: {
            (tweets, error) in
            
            self.tableView.hidden = false
            self.tweets = tweets
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath
    ) -> UITableViewCell {
        println("indexpath \(indexPath.row)")
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCellWithIdentifier(
                "ProfileTableViewCell"
            ) as ProfileTableViewCell

            if let user = self.user {
                cell.populate(self.user!)
            }

            return cell
        } else {

            let cell = tableView.dequeueReusableCellWithIdentifier(
                "TweetTableViewCell"
            ) as HomeTableViewCell
            
            if let tweets = self.tweets {
                cell.populate(self.tweets![indexPath.row], parent: self)
            }
            
            return cell
        }
    }
    
    func tableView(
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
}




