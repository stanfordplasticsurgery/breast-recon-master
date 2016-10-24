//
//  GalleryTextOverlay.swift
//  BreastRecon
//
//  Created by Randall Nickerson on 11/18/14.
//  Copyright (c) 2014 Crane Style Labs. All rights reserved.
//

import UIKit

class GalleryTextOverlay: UIView {
    
    var collapsedSize:CGFloat?
    var text:String?
    
    var textColor:UIColor = UIColor.whiteColor()
    var textAlpha:CGFloat = 1.0
    var label:UILabel = UILabel()

    private let defaultBackgroundColor:UIColor = UIColor.blackColor()
    private let defaultBackgroundAlpha:CGFloat = 0.75
    private let defaultTextColor:UIColor = UIColor.whiteColor()
    private let defaultTextAlpha:CGFloat = 1.0
    private let defaultTextAlignment = NSTextAlignment.Center
    private let textOverlayFontSize: CGFloat = 20.0
    
    
    // -- INITS
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //--

    func setup() {
        setupBackgroundDefault()
        self.setupLabel()
        self.addSubview(label)

        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        appDelegate.window?.rootViewController?.view.addSubview(self)

        self.hidden = true
    }
    
    func setupLabel() {
        self.label.frame = CGRect(origin: CGPoint(x: 10, y: 10), size: CGSize(width: self.bounds.width - 20, height: self.bounds.height - 20))
        self.label.numberOfLines = 0
        self.label.textColor = AppConfig.sharedInstance.basecolor_white()
        self.label.font = AppConfig.sharedInstance.font_default_regular(self.textOverlayFontSize)
    }
    
    func setupBackgroundDefault() {
        self.backgroundColor = self.defaultBackgroundColor
        self.alpha = self.defaultBackgroundAlpha
    }
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
