//
//  LoginViewController.swift
//  CaptureTheBeacon
//
//  Created by dvermeir on 06/07/15.
//  Copyright (c) 2015 iMinds. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    var email:String!

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        var currentUser = PFUser.currentUser();
        if currentUser != nil {
            self.performSegueWithIdentifier("loggedIn", sender:self)
        }
        
        // Do any additional setup after loading the view.
        let leftConstraint = NSLayoutConstraint(
            item:self.contentView,
            attribute:NSLayoutAttribute.Leading,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self.view,
            attribute:NSLayoutAttribute.Left,
            multiplier:1.0,
            constant:0
        )
        self.view.addConstraint(leftConstraint);
        
        let rightConstraint = NSLayoutConstraint(
            item:self.contentView,
            attribute:NSLayoutAttribute.Trailing,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self.view,
            attribute:NSLayoutAttribute.Right,
            multiplier:1.0,
            constant:0
        )
        self.view.addConstraint(rightConstraint)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Handles cancelled registration
    @IBAction func registrationCancelled(segue:UIStoryboardSegue) {
        
    }
    
    //Handles registration
    @IBAction func registerTapped(segue:UIStoryboardSegue) {
        self.emailField.text = email
    }
    
    //Handles logout
    @IBAction func logoutTapped(segue:UIStoryboardSegue) {
        self.passwordField.text = ""
    }
    
    
    /*
    Login user
    */
    @IBAction func loginTapped(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(self.emailField.text, password: self.passwordField.text) {
            (user: PFUser?, error:NSError?) -> Void in
            if user != nil {
                //Success
                self.performSegueWithIdentifier("loggedIn", sender: self)
            } else {
                //Failed
                var alert = UIAlertController(title: "Login", message: "Failed", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }


}
