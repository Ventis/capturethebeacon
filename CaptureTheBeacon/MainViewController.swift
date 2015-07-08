//
//  MainViewController.swift
//  CaptureTheBeacon
//
//  Created by dvermeir on 07/07/15.
//  Copyright (c) 2015 iMinds. All rights reserved.
//

import UIKit
import Parse

class MainViewController: UIViewController {
    
    var currentUser:PFUser!

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var playerTeam: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.currentUser = PFUser.currentUser()!
        //self.playerLabel.text = self.currentUser["nick"]
        //let teamName = "team " + currentUser["team"] as String
        //self.playerTeam.text = teamName
        
        switch currentUser["team"] as! String {
            case "red":
                self.playerTeam.textColor = UIColor.redColor()
            case "blue":
                self.playerTeam.textColor = UIColor.blueColor()
            default:
                self.playerTeam.textColor = UIColor.blackColor()
        }
        
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
    
    
    //Logs out user
    @IBAction func logout(sender: AnyObject) {
        PFUser.logOut()
        self.performSegueWithIdentifier("loggedOut", sender: self)
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
