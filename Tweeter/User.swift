//
//  User.swift
//  Tweeter
//
//  Created by Jehan Tremback on 2/20/15.
//  Copyright (c) 2015 Jehan Tremback. All rights reserved.
//

var _currentUser: User?
let currentUserKey = "currentUser"

import UIKit

class User: NSObject {
    var displayName: String?
    var username: String?
    var avatarURL: String?
    var tagline: String?
    var dictionary:  NSDictionary
   
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        displayName = dictionary["name"] as? String
        username = dictionary["screen_name"] as? String
        avatarURL = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                var data = NSUserDefaults.standardUserDefaults().objectForKey(
                    currentUserKey
                ) as? NSData
            
                if data != nil {
                    var dictionary = NSJSONSerialization.JSONObjectWithData(
                        data!,
                        options: nil,
                        error: nil
                    ) as NSDictionary
                    
                    _currentUser = User(dictionary: dictionary)
                }
            }
        
            return _currentUser
        }
        
        set (user) {
            _currentUser = user
            
            if currentUser != nil {
                var data = NSJSONSerialization.dataWithJSONObject(
                    user!.dictionary,
                    options: nil,
                    error: nil
                )
                
                NSUserDefaults.standardUserDefaults().setObject(
                    data,
                    forKey: currentUserKey
                )
            } else {
                NSUserDefaults.standardUserDefaults().setObject(
                    nil,
                    forKey: currentUserKey
                )
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
