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
    @IBOutlet weak var retweetedLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var retweetedImage: UIImageView!
    @IBOutlet weak var retweetedImageHeight: NSLayoutConstraint!
    @IBOutlet weak var retweetedImageOffset: NSLayoutConstraint!

    
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
        usernameLabel.text = "@\(tweet.user?.username)"
        contentLabel.text = tweet.content

        avatarImage.setImageWithURL(NSURL(string: (tweet.user?.avatarURL)!))
        retweetedImage.hidden = true
        retweetedImageHeight.constant = 0.0
        retweetedLabel.hidden = true
        retweetedLabelHeight.constant = 0.0
        retweetedImageOffset.constant = 0.0
        
    }
}
