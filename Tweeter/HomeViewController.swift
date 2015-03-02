//
//  HomeViewController.swift
//  Tweeter
//
//  Created by Jehan Tremback on 2/19/15.
//  Copyright (c) 2015 Jehan Tremback. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SideBarDelegate {
    @IBOutlet weak var tableView: UITableView!

    @IBAction func signOutAction(sender: AnyObject) {
        User.currentUser = nil
        self.performSegueWithIdentifier("logoutSegue", sender: self)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    var tweets: [Tweet]?
    var refreshControl: UIRefreshControl!
    var sideBar = SideBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        tableView.hidden = true
        
        sideBar = SideBar(sourceView: self.view, menuItems: ["Profile", "Home", "Mentions"])
        sideBar.delegate = self

        refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self,
            action: "getTweets",
            forControlEvents: UIControlEvents.ValueChanged
        )

        let dummyTableVC = UITableViewController()
        dummyTableVC.tableView = tableView
        dummyTableVC.refreshControl = refreshControl
        
        navigationItem.title = "Home"
        getTweets()

    }

    func getTweets () {
        TwitterClient.sharedInstance.getHomeTweetsForCurrentUser({
            (tweets, error) in
            
            self.tableView.hidden = false
            self.tweets = tweets
            self.tableView.reloadData()

            self.refreshControl.endRefreshing()
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
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "HomeTableViewCell"
        ) as HomeTableViewCell
        
        if let tweets = self.tweets {
            cell.profileButtonOutlet.tag = indexPath.row
            cell.populate(self.tweets![indexPath.row], parent: self)
        }
        
        return cell
    }
    
    func tableView(
        tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        println("section: \(section)")
        if let tweets = self.tweets {
            println("tweets count \(tweets.count)")
            return tweets.count
        } else {
            return 0
        }
    }

    func sideBarDidSelectButtonAtIndex(index: Int) {
        if index == 0 {
            self.performSegueWithIdentifier("myProfileSegue", sender: self)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "tweetDetailSegue") {
            let indexPath = self.tableView.indexPathForSelectedRow()!
            let dest = segue.destinationViewController as TweetDetailViewController
            dest.tweet = tweets?[indexPath.row]
            
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        } else if (segue.identifier == "myProfileSegue") {
            let dest = segue.destinationViewController as ProfileViewController
            let user = User.currentUser
            dest.populate(user!)
        }  else if (segue.identifier == "otherProfileSegue") {
            let dest = segue.destinationViewController as ProfileViewController
            let user: AnyObject? = sender? as User
            dest.populate(user!)
        }
    }
}
