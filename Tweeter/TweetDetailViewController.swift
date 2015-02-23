//
//  TweetDetailViewController.swift
//  Tweeter
//
//  Created by Jehan Tremback on 2/21/15.
//  Copyright (c) 2015 Jehan Tremback. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    @IBOutlet weak var retweetedLabel: UILabel!
    @IBOutlet weak var retweetedLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var retweetedImage: UIImageView!
    @IBOutlet weak var retweetedImageHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var agoLabel: UILabel!

    
    @IBOutlet weak var retweetsNumberLabel: UILabel!
    @IBOutlet weak var favoritesNumberLabel: UILabel!
    
    @IBOutlet weak var retweetButtonImage: UIImageView!
    @IBAction func retweetButtonAction(sender: AnyObject) {
        println("tried")
        TwitterClient.sharedInstance.retweet(tweet.ID) {
            (tweet, error) -> () in
            if error == nil {
                println("RT")
                self.retweetButtonImage.image = UIImage(named: "retweet-on")
            }
        }
    }
    
    @IBOutlet weak var favoriteButtonImage: UIImageView!
    @IBAction func favoriteButtonAction(sender: AnyObject) {
        println("tried")
        TwitterClient.sharedInstance.favorite(tweet.ID) {
            (error) -> () in
            if error == nil {
                println("FAVE")
                self.favoriteButtonImage.image = UIImage(named: "favorite-on")
            }
        }
    }

    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayNameLabel.text = tweet.user?.displayName
        usernameLabel.text = "@\((tweet.user?.username)!)"
        contentLabel.text = tweet.content

        avatarImage.setImageWithURL(NSURL(string: (tweet.user?.avatarURL)!))
        retweetedImage.hidden = true
        retweetedImageHeight.constant = 0.0
        retweetedLabel.hidden = true
        retweetedLabelHeight.constant = 0.0
        
        retweetsNumberLabel.text = "\(tweet.retweetsNumber!)"
        favoritesNumberLabel.text = "\(tweet.favoritesNumber!)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
////         Get the new view controller using segue.destinationViewController.
////         Pass the selected object to the new view controller.
//    }

}
