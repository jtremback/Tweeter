//
//  User.swift
//  Tweeter
//
//  Created by Jehan Tremback on 2/20/15.
//  Copyright (c) 2015 Jehan Tremback. All rights reserved.
//

var _currentUser: User?
let currentUserKey = "currentUser"
let logoutNotification = "logoutNotification"

import UIKit

class User: NSObject {
    var displayName: String?
    var username: String?
    var avatarURL: String?
    var tagline: String?
    var user_id: String?
    var banner_url: String?
    var background_url: String?
    var followers_count: Int?
    var friends_count: Int?
    var statuses_count: Int?
    var dictionary:  NSDictionary
   
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        user_id = dictionary["id_str"] as? String
        displayName = dictionary["name"] as? String
        username = dictionary["screen_name"] as? String
        avatarURL = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
        
        followers_count = dictionary["followers_count"] as? Int
        friends_count = dictionary["friends_count"] as? Int
        statuses_count = dictionary["statuses_count"] as? Int
        
        banner_url = dictionary["profile_banner_url"] as? String
        background_url = dictionary["profile_background_image_url"] as? String
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(logoutNotification, object: nil)
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
        
            return _currentUser
        }
        
        set (user) {
            _currentUser = user
            
            if _currentUser != nil {
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: nil, error: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
