//
//  MenuItemGallery.swift
//  BreastRecon
//
//  Created by Chi Kwan on 11/6/14.
//  Copyright (c) 2014 Crane Style Labs. All rights reserved.
//

import Foundation

class MenuItemGallery: MenuItem {
    var images:[GalleryImage]?
    var details: String?
    
    override init() {
        super.init()
    }
    
    init(details:String, imagesArray:NSArray) {
        super.init()
        
        self.images = []
        self.details = details
        self.setupMenuItemGallery(imagesArray)
    }
    
    private func setupMenuItemGallery(imagesArray:NSArray) {
        for image in imagesArray {
            self.addImage(GalleryImage(configFileImage: image as NSDictionary))
        }
    }
    
    func addImage(image:GalleryImage) {
        self.images?.append(image)
    }
}

