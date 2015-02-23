//
//  ComposeViewController.swift
//  Tweeter
//
//  Created by Jehan Tremback on 2/19/15.
//  Copyright (c) 2015 Jehan Tremback. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func tweetButtonPressed(sender: AnyObject) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.becomeFirstResponder()
        displayNameLabel.text = User.currentUser?.displayName
        usernameLabel.text = "@\((User.currentUser?.username)!)"
        avatarImage.setImageWithURL(NSURL(string: (User.currentUser?.avatarURL)!))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
