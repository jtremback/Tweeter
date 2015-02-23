//
//  HomeViewController.swift
//  Tweeter
//
//  Created by Jehan Tremback on 2/19/15.
//  Copyright (c) 2015 Jehan Tremback. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    var tweets: [Tweet]?
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120

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
        // Do any additional setup after loading the view.
    }

    func getTweets () {
        TwitterClient.sharedInstance.getHomeTweetsForCurrentUser({
            (tweets, error) in
            
            if error != nil {
                self.tableView.hidden = true
            } else {
                self.tableView.hidden = false
                self.tweets = tweets
                self.tableView.reloadData()
            }

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
            cell.populate(self.tweets![indexPath.row])
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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "tweetDetailSegue") {
            let indexPath = self.tableView.indexPathForSelectedRow()!
            let dest = segue.destinationViewController as TweetDetailViewController
            dest.tweet = tweets?[indexPath.row]
            
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
