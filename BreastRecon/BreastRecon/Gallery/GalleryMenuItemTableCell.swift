//
//  GalleryMenuItemTableCell.swift
//  BreastRecon
//
//  Created by Randall Nickerson on 11/3/14.
//  Copyright (c) 2014 Crane Style Labs. All rights reserved.
//

import UIKit

class GalleryMenuItemTableCell: UITableViewCell {

    
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var labelIndent: NSLayoutConstraint!
    @IBOutlet weak var leftIcon: UIImageView!
    @IBOutlet weak var rightIcon: UIImageView!
    
    var type:MenuItemType! {
        didSet {
            self.setupIcons(self.type)
        }
    }
    
    
    let fontSize:CGFloat = 17.0

    var cellHeight:CGFloat!
    var indent:CGFloat! = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let appConfig:AppConfig = AppConfig.sharedInstance
        let font:UIFont = AppConfig.sharedInstance.font_default_regular(fontSize)
        let selectedView:UIView = UIView()
        
        selectedView.backgroundColor = appConfig.menuSubItem_selected()
        
        self.selectedBackgroundView = selectedView

        if self.respondsToSelector(Selector("layoutMargins")) {
            self.layoutMargins  = UIEdgeInsetsZero //ios8
        }
        self.separatorInset = UIEdgeInsetsZero //ios7 & 8

        self.itemLabel.font = font
        self.itemLabel.numberOfLines = 2
        self.itemLabel.textColor = appConfig.menuItemLabel_foreground()
        self.contentView.backgroundColor = appConfig.menuItem_background()
    }

    func configureSeparator() {
        let appConfig:AppConfig = AppConfig.sharedInstance
        let separatorHeight = 1.0/UIScreen.mainScreen().scale
        var separator = UIView(frame: CGRectMake(0, self.bounds.origin.y + self.cellHeight - separatorHeight, self.itemLabel.frame.size.width, separatorHeight))
        separator.backgroundColor = appConfig.menu_seperator()
        self.addSubview(separator)
    }
    
    func setupIcons(type:MenuItemType) {
        var leftIconImageName:String = ""
        var rightIconImageName:String = ""
        
        switch (type) {
        case .Document:
            leftIconImageName = "icon-single-document"
        case .Gallery:
            leftIconImageName = "icon-multiple-images"
        case .Menu:
            leftIconImageName = "icon-multiple-documents"
            rightIconImageName = "icon-right-arrow"
        default:
            fatalError("Unexpected MenuItemType")
        }
        
        let leftIconImage = UIImage(named: leftIconImageName)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.leftIcon.tintColor = AppConfig.sharedInstance.menuItemLabel_foreground()
        self.leftIcon.image = leftIconImage
        
        if (rightIconImageName != "") {
            let rightIconImage:UIImage = UIImage(named: "icon-right-arrow")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            self.rightIcon.tintColor = AppConfig.sharedInstance.menuItemLabel_foreground()
            self.rightIcon.image = rightIconImage
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        let appConfig:AppConfig = AppConfig.sharedInstance
        if selected {
            self.itemLabel.textColor = appConfig.menuItemLabel_selected()
            self.leftIcon.tintColor = appConfig.menuItem_icon_selected()
            self.rightIcon.tintColor = appConfig.menuItem_icon_selected()
        } else {
            self.itemLabel.textColor = appConfig.menuItemLabel_foreground()
            self.leftIcon.tintColor = appConfig.menuItem_icon_normal()
            self.rightIcon.tintColor = appConfig.menuItem_icon_normal()
        }
    }

}
