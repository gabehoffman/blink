//
//  WelcomeViewController.swift
//  Blink
//
//  Created by Gabe at Work on 3/2/16.
//  Copyright © 2016 Hoffman Tools. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Preparing for Seque")
        if segue.identifier == "startBlink" {
            var vc = segue.destinationViewController as! DataURLLoadable
            vc.dataURL = NSBundle.mainBundle().URLForResource("hexagonTest", withExtension: "json")
        }
    }

}