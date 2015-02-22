//
//  HomeTableViewCell.swift
//  Tweeter
//
//  Created by Jehan Tremback on 2/20/15.
//  Copyright (c) 2015 Jehan Tremback. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var agoLabel: UILabel!
    @IBOutlet weak var retweetedLabel: UILabel!
    @IBOutlet weak var retweetedImage: UIImageView!
    
    @IBOutlet weak var retweetImage: UIImageView!
    @IBOutlet weak var replyImage: UIImageView!
    @IBOutlet weak var favoriteImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func populate (tweet: Tweet) {
        displayNameLabel.text = tweet.user?.displayName
        usernameLabel.text = tweet.user?.username
        contentLabel.text = tweet.content
        
//        let avatarURL = tweet.user?.avatarURL
//        avatarImage.setImageWithURL(NSURL(string: avatarURL!))
        
        avatarImage.setImageWithURL(NSURL(string: (tweet.user?.avatarURL)!))
//        agoLabel.text = tweet.createdAtString
//        retweetedLabel.text
        
    }
}
