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
    @IBOutlet weak var staminaBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.currentUser = PFUser.currentUser()!
        currentUser.fetch()

        self.playerLabel.text = currentUser["nick"] as? String
        var teamName = "Team "
        teamName += currentUser["team"] as! String
        self.playerTeam.text = teamName
        
        switch currentUser["team"] as! String {
            case "red":
                self.playerTeam.textColor = UIColor.redColor()
                self.staminaBar.progressTintColor = UIColor.redColor()
            case "blue":
                self.playerTeam.textColor = UIColor.blueColor()
                self.staminaBar.progressTintColor = UIColor.blueColor()
            default:
                self.playerTeam.textColor = UIColor.blackColor()
                self.staminaBar.progressTintColor = UIColor.grayColor()
        }
        var stamina = currentUser["stamina"] as? Int != nil ? currentUser["stamina"] as! Int : 0
        self.staminaBar.progress = Float(stamina)/100
        
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
        
        let topConstraint = NSLayoutConstraint(
            item:self.contentView,
            attribute:NSLayoutAttribute.Top,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self.view,
            attribute:NSLayoutAttribute.Top,
            multiplier:1.0,
            constant:65
        )
        self.view.addConstraint(topConstraint)

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
