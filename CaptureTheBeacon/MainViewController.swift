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
    @IBOutlet weak var staminaLabel: UILabel!
    @IBOutlet weak var redBeacons: UILabel!
    @IBOutlet weak var neutralBeacons: UILabel!
    @IBOutlet weak var blueBeacons: UILabel!
   
    var uiUpdateTimer: NSTimer? = nil
    var updateInterval: NSTimeInterval = 10

    
    func shutdown() {
        self.uiUpdateTimer!.invalidate()
        self.uiUpdateTimer = nil
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateData()
        self.uiUpdateTimer = NSTimer.scheduledTimerWithTimeInterval(self.updateInterval, target: self, selector: "updateData", userInfo: nil, repeats: true)
        
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
        
//        let topConstraint = NSLayoutConstraint(
//            item:self.contentView,
//            attribute:NSLayoutAttribute.Top,
//            relatedBy:NSLayoutRelation.Equal,
//            toItem:self.view,
//            attribute:NSLayoutAttribute.Top,
//            multiplier:1.0,
//            constant:65
//        )
//        self.view.addConstraint(topConstraint)

    }
    
    
    //Updates all data on screen
    func updateData() {
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
        self.staminaLabel.text = String(stamina)+"/100 capture points left"
        
        var query = PFQuery(className:"Beacon")
        query.findObjectsInBackgroundWithBlock {
            (beacons: [AnyObject]?, error: NSError?) -> Void in
            var redCount = 0
            var blueCount = 0
            var neutralCount = 0
            if let error = error {
                //Error
            } else {
                if beacons != nil {
                    for beacon in beacons! {
                        var beaconTeam = beacon["team"] as? String != nil ? beacon["team"] as! String : ""
                        switch beaconTeam {
                        case "red":
                            redCount++
                        case "blue":
                            blueCount++
                        default:
                            neutralCount++
                        }
                        
                    }
                }
            }
            
            self.redBeacons.text = String(redCount)
            self.blueBeacons.text = String(blueCount)
            self.neutralBeacons.text = String(neutralCount)
        }
        
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
