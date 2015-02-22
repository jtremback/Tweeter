//
//  Tweet.swift
//  Tweeter
//
//  Created by Jehan Tremback on 2/20/15.
//  Copyright (c) 2015 Jehan Tremback. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var content: String?
    var user: User?
    var createdAtString: String?
    var createdAt: NSDate?
    var avatarImageURL: NSURL?

    init(dictionary: NSDictionary) {
        println("\n\n\n\n\(dictionary)")
        user = User(dictionary: dictionary["user"] as NSDictionary)
        content = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
    }
    
    class func tweetsWithArray (array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
}