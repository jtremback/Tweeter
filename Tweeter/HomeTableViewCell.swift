//
//  HomeTableViewCell.swift
//  Tweeter
//
//  Created by Jehan Tremback on 2/20/15.
//  Copyright (c) 2015 Jehan Tremback. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    var tweet: Tweet?

    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var agoLabel: UILabel!
    
    @IBOutlet weak var retweetedLabel: UILabel!
    @IBOutlet weak var retweetedLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var retweetedImage: UIImageView!
    @IBOutlet weak var retweetedImageHeight: NSLayoutConstraint!
    @IBOutlet weak var retweetedImageOffset: NSLayoutConstraint!

    
//    @IBOutlet weak var replyButtonImage: UIImageView!
//    @IBAction func replyButtonAction(sender: AnyObject) {
//
//    }
//    
    @IBOutlet weak var retweetButtonImage: UIImageView!
    @IBAction func retweetButtonAction(sender: AnyObject) {
        println("tried")
        TwitterClient.sharedInstance.retweet(tweet?.ID) {
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
        TwitterClient.sharedInstance.favorite(tweet?.ID) {
            (error) -> () in
            if error == nil {
                println("FAVE")
                self.favoriteButtonImage.image = UIImage(named: "favorite-on")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func populate (tweet: Tweet) {
        self.tweet = tweet
        
        displayNameLabel.text = tweet.user?.displayName
        let username = tweet.user?.username
        usernameLabel.text = "@\(username!)"
        contentLabel.text = tweet.content

        avatarImage.setImageWithURL(NSURL(string: (tweet.user?.avatarURL)!))
        retweetedImage.hidden = true
        retweetedImageHeight.constant = 0.0
        retweetedLabel.hidden = true
        retweetedLabelHeight.constant = 0.0
        retweetedImageOffset.constant = 0.0
        agoLabel.text = tweet.createdAt?.relativeTime
    }
}
