//
//  MenuItemMenu.swift
//  BreastRecon
//
//  Created by Randall Nickerson on 1/9/15.
//  Copyright (c) 2015 Crane Style Labs. All rights reserved.
//

import UIKit

class MenuItemMenu: MenuItem {
    
    var items:Array<MenuItem> = Array<MenuItem>()
    
    init(menuData:NSArray) {
        super.init()
        for menuItemData in menuData {
            self.items.append(MenuItem.get(menuItemData as NSDictionary))
        }
    }
   
}
