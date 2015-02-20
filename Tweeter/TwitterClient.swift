//
//  TwitterClient.swift
//  Tweeter
//
//  Created by Jehan Tremback on 2/17/15.
//  Copyright (c) 2015 Jehan Tremback. All rights reserved.
//

import UIKit

let twitterConsumerKey = "slNyELMNkNS2QLkFDttDbIpOE"
let twitterConsumerSecret = "HnONE6Nl7QF1OyQ3tdXDrhErZDmSQnAnBOLNEAxU3kRDosqwqs"
let twitterBaseUrl = NSURL(string: "https://api.twitter.com/")

class TwitterClient: BDBOAuth1RequestOperationManager {
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(
                baseURL: twitterBaseUrl,
                consumerKey: twitterConsumerKey,
                consumerSecret: twitterConsumerSecret
            )
        }
        
        return Static.instance
    }
}
