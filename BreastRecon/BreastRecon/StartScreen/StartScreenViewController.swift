//
//  StartScreenViewController.swift
//  BreastRecon
//
//  Created by Randall Nickerson on 10/20/14.
//  Copyright (c) 2014 Crane Style Labs. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {

    
    @IBOutlet weak var dialogLabel: UILabel!
    
    let hideNavigationBar:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dialogLabel.font = AppConfig.sharedInstance.font_default_bolditalic(32)
        self.dialogLabel.text = "Welcome to the Breast Reconstructive Surgery information app!\nTap the Start button to begin"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(hideNavigationBar, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func startButtonTapped(sender: UIButton, forEvent event: UIEvent) {
        let categoryScreenViewController: UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier("CategoryScreenViewController") as CategoryScreenViewController
        self.navigationController?.pushViewController(categoryScreenViewController, animated: true)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
