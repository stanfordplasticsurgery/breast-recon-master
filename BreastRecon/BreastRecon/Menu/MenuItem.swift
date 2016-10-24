//
//  Menu.swift
//  BreastRecon
//
//  Created by Chi Kwan on 11/6/14.
//  Copyright (c) 2014 Crane Style Labs. All rights reserved.
//

import Foundation

enum MenuItemType {
    case Document
    case Gallery
    case Menu
}

class MenuItem: NSObject {
    var title: String!
    var type: MenuItemType!
    var data: NSObject?

    override init(){
        super.init()
    }
    
    class func get(menuItemData:NSDictionary) -> MenuItem {
        let type = menuItemData["type"] as String
        let title = menuItemData["title"] as String
        let data = menuItemData["data"] as NSObject
        
        var details:String = ""
        if ((menuItemData["details"]) != nil) {
            details = menuItemData["details"] as String
        }
        
        var menuItem:MenuItem!
        
        switch type {
        case "document":
            menuItem = MenuItemDocument(data: data as String)
            menuItem.type = MenuItemType.Document
        case "gallery":
            menuItem = MenuItemGallery(details: details, imagesArray: data as NSArray)
            menuItem.type = MenuItemType.Gallery
        case "menu":
            menuItem = MenuItemMenu(menuData: data as NSArray)
            menuItem.type = MenuItemType.Menu
        default:
            fatalError("Unexpected MenuItemType")
        }
        
        menuItem.title = menuItem.parseTitleText(title)
        
        return menuItem
    }
    
    func parseTitleText(title:String) -> String {
        var nsTitle:NSString = title as NSString
        
        let replaceNewLineString:String = "\\n"
        let withNewLineString:String = "\n"
        
        let replaceTabString:String = "\\t"
        let withTabString:String = "\t"
        
        nsTitle = nsTitle.stringByReplacingOccurrencesOfString(replaceTabString, withString: withTabString) as String
        nsTitle = nsTitle.stringByReplacingOccurrencesOfString(replaceNewLineString, withString: withNewLineString) as String
        
        return nsTitle
    }
    
}