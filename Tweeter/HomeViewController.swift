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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        navigationItem.title = "Home"
        TwitterClient.sharedInstance.getHomeTweetsForCurrentUser({
            (tweets, error) in
            self.tweets = tweets
            self.tableView.reloadData()
        })
        // Do any additional setup after loading the view.
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
    
//    func tableView(
//        tableView: UITableView!,
//        cellTypeForRowWithIndexPath indexPath: NSIndexPath!
//    ) -> UITableViewCellAccessoryType {
//        let cell = tableView.dequeueReusableCellWithIdentifier(
//            "HomeTableViewCell"
//        ) as HomeTableViewCell
//        
//        return cell
//    }
    
    func tableView(
        tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 20
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
