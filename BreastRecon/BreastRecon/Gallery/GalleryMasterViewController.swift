//
//  GalleryMasterViewController.swift
//  BreastRecon
//
//  Created by Randall Nickerson on 10/29/14.
//  Copyright (c) 2014 Crane Style Labs. All rights reserved.
//

import UIKit

class GalleryMasterViewController: UITableViewController, UIWebViewDelegate {

    // MARK: - Variables
    var items:Array<MenuItem> = Array<MenuItem>()

    var documentDetailController :DocumentationDetailViewController!
    var galleryDetailController :GalleryContainerViewController!
    var lastSelectedIndexPath:  NSIndexPath?
    
    let fontSize:CGFloat = 20.0
    let sidebarBackground:String = "sidebar_background"

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        self.documentDetailController = self.storyboard?.instantiateViewControllerWithIdentifier("DocumentationDetailView") as DocumentationDetailViewController
        self.documentDetailController.configureWebView()
        self.documentDetailController.webView.delegate = self
        self.documentDetailController.view.addSubview(self.documentDetailController.webView)

        self.galleryDetailController = self.storyboard?.instantiateViewControllerWithIdentifier("GalleryDetailViewController") as GalleryContainerViewController


//        self.splitViewController?.viewControllers[1] = self.documentDetailController
//        self.galleryDetailController.thumbnailCollection = UICollectionView()
//        self.galleryDetailController.setupThumbnailCollectionView()
//        self.galleryDetailController.setupBigDocument()
//        self.galleryDetailController.setupBigPicture()
//        self.galleryDetailController.setupTextOverlay()


        self.configureNavBar()
        
        lastSelectedIndexPath = NSIndexPath(forRow: 0, inSection: 0)
    }

    func configureNavBar() {
        self.navigationController?.navigationBar.tintColor = AppConfig.sharedInstance.menu_navbar_text()
        
        // Back Button
        let backButton:UIBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Bordered, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton

        // "Fake" Back Button
        if (self === self.navigationController?.viewControllers[0]) {
            let imageBack = UIImage(named:"icon-left-arrow")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)

            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 36))
            button.setImage(imageBack, forState: UIControlState.Normal)
            button.addTarget(self, action: Selector("homeButtonTapped:"), forControlEvents: UIControlEvents.TouchUpInside)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 15)
            button.tintColor = AppConfig.sharedInstance.menu_navbar_text()

            let fakeBackButton:UIBarButtonItem = UIBarButtonItem(customView: button)
            self.navigationItem.leftBarButtonItem = fakeBackButton
        }

        // Home Button
        let image = UIImage(named:"home_button")
        let homeButton = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: Selector("homeButtonTapped:"))
        homeButton.image = homeButton.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        self.navigationItem.rightBarButtonItem = homeButton
    }

    // MARK: - ViewWillAppear

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setupTableView()
        self.tableView.reloadData()
        self.showLastSelectedMenuItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func showLastSelectedMenuItem() {
        if (self.items.count > 0) {
            let row = lastSelectedIndexPath!.row as NSInteger
            let menuItem:MenuItem = self.items[row]
            self.tableView.selectRowAtIndexPath(lastSelectedIndexPath, animated: false, scrollPosition: UITableViewScrollPosition.Top)
            if (menuItem.type != MenuItemType.Menu) {
                self.showMenuItem(menuItem)
            } else {
                var defaultHtmlDocument:MenuItemDocument = MenuItemDocument(data: "blank.html")
                defaultHtmlDocument.type = MenuItemType.Document
                self.showMenuItem(defaultHtmlDocument)
            }
        }
    }

    private func setupTableView() {
        var titleFont:UIFont = AppConfig.sharedInstance.font_default_regular(self.fontSize)
        self.tableView.tableFooterView = UIView()
        self.navigationController?.navigationBar.barTintColor = AppConfig.sharedInstance.menuNavBar_background()
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: titleFont, NSForegroundColorAttributeName: AppConfig.sharedInstance.menu_navbar_text()]
        self.tableView.backgroundColor = AppConfig.sharedInstance.menu_background()
        self.tableView.separatorColor = AppConfig.sharedInstance.menu_seperator()
    }

    private func showMenuItem(menuItem: MenuItem){
        
        let type:MenuItemType = menuItem.type
        
        switch (type) {
        case MenuItemType.Document:
            let documentItem = menuItem as MenuItemDocument
            processDocumentItem(documentItem)
        case MenuItemType.Gallery:
            let galleryItem = menuItem as MenuItemGallery
            galleryDetailController.currentImageIndex = 0
            processGalleryItem(galleryItem)
        case MenuItemType.Menu:
            var controller = self.storyboard?.instantiateViewControllerWithIdentifier("MasterView") as GalleryMasterViewController
            let menuItemMenu:MenuItemMenu = menuItem as MenuItemMenu
            controller.items = menuItemMenu.items as Array<MenuItem>
            controller.title = menuItemMenu.title
            controller.navigationItem.title = menuItemMenu.title
            self.navigationController?.pushViewController(controller, animated: true)
        default:
            fatalError("Unrecognized MenuItemType")
        }
    }

    private func loadDetailViewController(viewController:UIViewController){
        self.splitViewController?.viewControllers[1] = viewController
    }

    private func processDocumentItem(item: MenuItemDocument){
        let request = item.html!.getNSURLRequest()
        documentDetailController.loadRequest(request)
    }
    
    private func processGalleryItem(galleryItem: MenuItemGallery){
        self.loadDetailViewController(self.galleryDetailController)
        galleryDetailController.showGallery(galleryItem)
    }
    
    // MARK: - Other View Controller Methods

    override func viewDidLayoutSubviews() {
        if self.tableView.respondsToSelector(Selector("layoutMargins")){
            self.tableView.layoutMargins  = UIEdgeInsetsZero //ios8
        }
        self.tableView.separatorInset = UIEdgeInsetsZero //ios7 & 8
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return items.count;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> GalleryMenuItemTableCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as GalleryMenuItemTableCell
        let menuItem = items[indexPath.row]
        cell.itemLabel.text = menuItem.title
        cell.type = menuItem.type
        cell.cellHeight = self.tableView(self.tableView, heightForRowAtIndexPath:indexPath)
        return cell
    }

    // MARK: - Table view delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let overlay = self.galleryDetailController.galleryTextOverlayView? {
            overlay.hidden = true
        }

        self.lastSelectedIndexPath = indexPath
        var menuItem: MenuItem = self.items[indexPath.row]
        self.showMenuItem(menuItem)
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60;
    }
    
    // MARK: - Button Functions
    func homeButtonTapped(sender: AnyObject) {
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        appDelegate.window?.rootViewController = appDelegate.nav
    }

    // MARK: - UI Web View Delegate

    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if (navigationType == UIWebViewNavigationType.LinkClicked) {
            let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            let webBrowser = self.storyboard?.instantiateViewControllerWithIdentifier("webBrowser") as WebBrowserViewController

            let navVC = appDelegate.gallerySplitViewController!.viewControllers[0] as GalleryNavController
            let masterVC = navVC.viewControllers[0] as GalleryMasterViewController
            webBrowser.url = request.URL
            appDelegate.window?.rootViewController = webBrowser

            return false
        }
        return true
    }

    func webViewDidFinishLoad(webView: UIWebView) {
        self.loadDetailViewController(self.documentDetailController)
    }
}
