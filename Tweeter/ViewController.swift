//
//  ViewController.swift
//  Tweeter
//
//  Created by Jehan Tremback on 2/17/15.
//  Copyright (c) 2015 Jehan Tremback. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            
            if user != nil {
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                println("FAAAAAAAAAAAAAAAAK")
            }
        }
    }


}

