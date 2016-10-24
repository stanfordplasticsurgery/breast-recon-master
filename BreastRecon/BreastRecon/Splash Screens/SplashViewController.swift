//
//  SplashViewController.swift
//  BreastRecon
//
//  Created by Randall Nickerson on 11/20/14.
//  Copyright (c) 2014 Crane Style Labs. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fadeDuration = 0.25
        let fadeDelay = 2.0
        self.view.backgroundColor = UIColor.blackColor()
        self.fadeOut(fadeDuration, delay: fadeDelay)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func nextScreen() {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        appDelegate.window?.rootViewController = appDelegate.nav
    }
    
    private func fadeOut(duration:NSTimeInterval, delay:NSTimeInterval) {
        UIView.animateWithDuration(duration,
            delay: delay,
            options: .CurveEaseIn,
            animations: { () in self.backgroundImage!.alpha = 0.0; },
            completion: { (Bool) in self.nextScreen(); })
    }

}
