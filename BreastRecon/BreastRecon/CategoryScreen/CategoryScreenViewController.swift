//
//  CategoryScreenViewController.swift
//  BreastRecon
//
//  Created by Randall Nickerson on 10/23/14.
//  Copyright (c) 2014 Crane Style Labs. All rights reserved.
//

import UIKit

class CategoryScreenViewController: UIViewController {
    
    
    @IBOutlet weak var dialogLabel: UILabel!
    @IBOutlet weak var doctorView: UIView!
    
    let hideNavigationBar:Bool = true
    let gallerySplitViewControllerId:String = "GalleryViewController"

    let kLocationIdBeforeSurgery:String = "BeforeSurgeryGallery"
    let kLocationIdAfterSurgery:String = "AfterSurgeryGallery"
    let kLocationIdSurgery:String = "SurgeryGallery"
    let kLocationIdReconstruction:String = "ReconstructionGallery"
    let kLocationIdResources:String = "ResourcesView"
    
    var dataFileObject:DataFileObject!
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.doctorView.clipsToBounds = true
        self.dialogLabel.font = AppConfig.sharedInstance.font_default_bolditalic(32)
        self.dialogLabel.text = "Now tap a button to get more information on that topic"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(hideNavigationBar, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func openSplitView(locationId:String?) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        appDelegate.gallerySplitViewController = self.storyboard?.instantiateViewControllerWithIdentifier(self.gallerySplitViewControllerId) as GallerySplitViewController
        appDelegate.galleryConfigFilename = locationId!
        
        self.dataFileObject = DataFileObject(dataFile: getPlistName(appDelegate.galleryConfigFilename!))
        
        let masterViewController = appDelegate.gallerySplitViewController.viewControllers[0].topViewController as GalleryMasterViewController
        let menuItemMenu:MenuItemMenu = MenuItem.get(self.dataFileObject.data) as MenuItemMenu
        masterViewController.items = menuItemMenu.items
        masterViewController.title = menuItemMenu.title
        appDelegate.window?.rootViewController = appDelegate.gallerySplitViewController
    }

    private func getPlistName(configFile: String) -> String{
        var plistName: String = ""
        switch configFile{
        case "BeforeSurgeryGallery":
            plistName = "BeforeSurgery"
        case "AfterSurgeryGallery":
            plistName = "AfterSurgery"
        case "SurgeryGallery":
            plistName = "BreastOncologySurgery"
        case "ReconstructionGallery":
            plistName = "ReconstructiveOptions"
        case "ResourcesView":
            plistName = "Resources"
        default:
            plistName = ""
        }
        return plistName
    }
    
    @IBAction func backButtonTapped(sender: AnyObject, forEvent event: UIEvent) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func beforeSurgeryButtonTapped(sender: AnyObject, forEvent event: UIEvent) {
        self.openSplitView(self.kLocationIdBeforeSurgery)
    }
    
    @IBAction func surgeryButtonTapped(sender: AnyObject, forEvent event: UIEvent) {
        self.openSplitView(self.kLocationIdSurgery)
    }
    
    @IBAction func afterSurgeryButtonTapped(sender: AnyObject, forEvent event: UIEvent) {
        self.openSplitView(self.kLocationIdAfterSurgery)
    }
    
    @IBAction func reconstructionButtonTapped(sender: AnyObject, forEvent event: UIEvent) {
        self.openSplitView(self.kLocationIdReconstruction)
    }
    
    @IBAction func resourcesButtonTapped(sender: UIButton, forEvent event: UIEvent) {
        self.openSplitView(self.kLocationIdResources)
    }
    
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        //
//    }

}
