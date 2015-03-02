//
//  ProfileTableViewCell.swift
//  Tweeter
//
//  Created by Jehan Tremback on 3/1/15.
//  Copyright (c) 2015 Jehan Tremback. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    var user: User?
    
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var headerImage: UIImageView!

    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populate (user: User) {
        self.user = user
        
        displayNameLabel.text = user.displayName
        let username = user.username
        usernameLabel.text = "@\(username!)"
        contentLabel.text = user.tagline
        
        tweetsLabel.text = "\(user.statuses_count!)"
        followingLabel.text = "\(user.friends_count!)"
        followersLabel.text = "\(user.followers_count!)"

        avatarImage.setImageWithURL(NSURL(string: (user.avatarURL)!))
        let banner = (user.banner_url != nil) ? user.banner_url : user.background_url!
        headerImage.setImageWithURL(NSURL(string: (banner)!))
    }

}
