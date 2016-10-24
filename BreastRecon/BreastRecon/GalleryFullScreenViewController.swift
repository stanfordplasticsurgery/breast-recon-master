//
//  GalleryScrollViewController.swift
//  BreastRecon
//
//  Created by Chi Kwan on 11/4/14.
//  Copyright (c) 2014 Crane Style Labs. All rights reserved.
//

import UIKit

class GalleryFullScreenViewController: UIViewController, UIScrollViewDelegate {

    // MARK: - Variables
    @IBOutlet weak var scrollView: UIScrollView!
    //var gallery: Gallery!
    var gallery: MenuItemGallery!
    var currentImageIndex: Int!
//    var tableState: Menu?
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        
        self.view.backgroundColor = AppConfig.sharedInstance.basecolor_teal()
        if (self.currentImageIndex == nil){
            self.currentImageIndex = 0
        }
        self.scrollView.pagingEnabled = true
        self.scrollView.scrollEnabled = true
 
        let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(gallery.images!.count),
            height: pagesScrollViewSize.height)
        
        loadPages()
        setScrollViewDefaultPosition()
        
        //[scrollView setContentOffset:CGPointMake(x, y) animated:YES];
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func loadPages(){
        for (index, image) in enumerate(gallery.images!){
            var frame = scrollView.bounds
            frame.origin.x = frame.size.width * CGFloat(index)
            frame.origin.y = 0.0

            if image.itemType == GalleryItemType.Document {
                let uiView:UIView = UIView()
                uiView.frame = frame
                uiView.backgroundColor = AppConfig.sharedInstance.menu_background()

                let webView:UIWebView = UIWebView()
                let offset:CGFloat = 160.5
                webView.frame = CGRectMake(offset, frame.origin.y, frame.size.width - (offset * 2), frame.size.height)
                webView.scrollView.scrollEnabled = false
                webView.opaque = false
                webView.backgroundColor = UIColor.clearColor()
                webView.clipsToBounds = true

                let ribbonImage = UIImage(named: "ribbon_xl")
                let imageView = UIImageView(image: ribbonImage)
                imageView.frame = webView.frame
                imageView.contentMode = UIViewContentMode.ScaleAspectFit
                imageView.backgroundColor = UIColor.clearColor()

                let whiteBackgroundView = UIView(frame: webView.frame)
                whiteBackgroundView.backgroundColor = UIColor.whiteColor()

                let request = image.html!.getNSURLRequest()
                webView.loadRequest(request)
                uiView.addSubview(whiteBackgroundView)
                webView.addSubview(imageView)
                webView.sendSubviewToBack(imageView)
                uiView.addSubview(webView)
                scrollView.addSubview(uiView)
            } else {
                let imageView: UIImageView = UIImageView(image: image.fullsize)
                imageView.frame = frame
                imageView.contentMode = UIViewContentMode.ScaleAspectFit
                scrollView.addSubview(imageView)
            }
        }
    }
    
    func setScrollViewDefaultPosition(){
        let x = scrollView.frame.size.width * CGFloat(currentImageIndex)
        scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }

    // MARK: - IBActions
    @IBAction func backButtonTapped(sender: UIButton, forEvent event: UIEvent) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let navVC = appDelegate.gallerySplitViewController!.viewControllers[0] as GalleryNavController
        let masterVC = navVC.viewControllers[0] as GalleryMasterViewController
//        masterVC.appMenu = tableState
        appDelegate.window?.rootViewController = appDelegate.gallerySplitViewController
    }

    // MARK:
}


















