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
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
//    var homeTweetsCompletion: ((tweets: [Tweet]?, error: NSError?) -> ())?

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
    
    
    func loginWithCompletion (
        completion: (user: User?, error: NSError?) -> ()
    ) {
        loginCompletion = completion
        
        // Fetch request token and redirect to auth page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath(
            "oauth/request_token",
            method: "GET",
            callbackURL: NSURL(string: "tweeter://oauth"),
            scope: nil,
            success: {(requestToken: BDBOAuth1Credential!) -> Void in
                println("Got the token")
                var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
                UIApplication.sharedApplication().openURL(authURL)
            },
            failure: {(error: NSError!) -> Void in
                println("Failed to receive access token.\(error.description)")
                self.loginCompletion?(user: nil, error: error)
            }
        )
    }
    
    
    func getHomeTweetsForCurrentUser (
        completion: (tweets: [Tweet]?, error: NSError?) -> ()
    ) {
        TwitterClient.sharedInstance.GET(
            "/1.1/statuses/home_timeline.json",
            parameters: nil,
            success: {
                (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
                
//                for tweet in tweets {
//                    println("tweet: \(tweet.content), created: \(tweet.createdAt)")
//                }
                
                completion(tweets: tweets, error: nil)
            },
            failure: {
                (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                
                completion(tweets: nil, error: error)
                println("Error getting home timeline.")
            }
        )
    }
    
    
    func openURL (url: NSURL) {
        TwitterClient.sharedInstance.fetchAccessTokenWithPath(
            "oauth/access_token",
            method: "POST",
            requestToken: BDBOAuth1Credential(queryString: url.query)!,
            success: {
                (accessToken: BDBOAuth1Credential!) -> Void in
                println("yup")
                TwitterClient.sharedInstance.requestSerializer.saveAccessToken(
                    accessToken
                )
                
                TwitterClient.sharedInstance.GET(
                    "/1.1/account/verify_credentials.json",
                    parameters: nil,
                    success: {
                        (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                        var user = User(dictionary: response as NSDictionary)
                        User.currentUser = user
                        println(user.displayName)
                    },
                    failure: {
                        (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                        println("lets try that again")
                    }
                )
                
                TwitterClient.sharedInstance.GET(
                    "/1.1/statuses/home_timeline.json",
                    parameters: nil,
                    success: {
                        (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                        var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
                        
                        for tweet in tweets {
                            println("tweet: \(tweet.content), created: \(tweet.createdAt)")
                        }
                    },
                    failure: {
                        (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                        println("Error getting home timeline.")
                    }
                )
            }
        ) {
            (error: NSError!) -> Void in
            println("nope")
        }
    }
}
