//
//  WebBrowserViewController.swift
//  BreastRecon
//
//  Created by Chi Kwan on 11/20/14.
//  Copyright (c) 2014 Crane Style Labs. All rights reserved.
//


import UIKit

class WebBrowserViewController: UIViewController{


    @IBOutlet weak var webView: UIWebView!

    var url: NSURL?
//    var tableState: Menu?
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadRequestFromString(url!)
    }
    
    // MARK: - Other View Controller Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadRequestFromString(url: NSURL){
        let urlRequest = NSURLRequest(URL: url)
        self.webView.loadRequest(urlRequest)
    }
    @IBAction func backButtonTapped(sender: UIBarButtonItem) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let navVC = appDelegate.gallerySplitViewController!.viewControllers[0] as GalleryNavController
        let masterVC = navVC.viewControllers[0] as GalleryMasterViewController
//        masterVC.appMenu = tableState
        appDelegate.window?.rootViewController = appDelegate.gallerySplitViewController
    }
}


