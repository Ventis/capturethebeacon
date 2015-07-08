//
//  RegisterViewController.swift
//  CaptureTheBeacon
//
//  Created by dvermeir on 06/07/15.
//  Copyright (c) 2015 iMinds. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nicknameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let leftConstraint = NSLayoutConstraint(
            item:self.contentView,
            attribute:NSLayoutAttribute.Leading,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self.view,
            attribute:NSLayoutAttribute.Left,
            multiplier:1.0,
            constant:0
        );
        self.view.addConstraint(leftConstraint);
        
        let rightConstraint = NSLayoutConstraint(
            item:self.contentView,
            attribute:NSLayoutAttribute.Trailing,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self.view,
            attribute:NSLayoutAttribute.Right,
            multiplier:1.0,
            constant:0
        );
        self.view.addConstraint(rightConstraint);
        
        let top = NSLayoutConstraint(
            item:self.contentView,
            attribute:NSLayoutAttribute.Top,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self.view,
            attribute:NSLayoutAttribute.Top,
            multiplier:1.0,
            constant:60
        );
        self.view.addConstraint(top);
        
        let bottom = NSLayoutConstraint(
            item:self.contentView,
            attribute:NSLayoutAttribute.Bottom,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self.view,
            attribute:NSLayoutAttribute.Bottom,
            multiplier:1.0,
            constant:0
        );
        self.view.addConstraint(bottom);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Register new player
    @IBAction func register(sender: AnyObject) {
        var user = PFUser()
        user.username = self.emailField.text
        user.password = self.passwordField.text
        user.email = self.emailField.text
        user["nick"] = self.nicknameField.text
        user["stamina"] = 100
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo?["error"] as? String
                var alert = UIAlertController(title: "Registration failed", message: errorString, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                // Hooray! Let them use the app now.
                self.performSegueWithIdentifier("registerTapped", sender: self)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "registerTapped") {
            var svc = segue.destinationViewController as! LoginViewController;
            
            svc.email = self.emailField.text
            
        }
    }

}
