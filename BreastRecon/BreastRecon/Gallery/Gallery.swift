//
//  Gallery.swift
//  BreastRecon
//
//  Created by Randall Nickerson on 10/31/14.
//  Copyright (c) 2014 Crane Style Labs. All rights reserved.
//

import UIKit

class Gallery: NSObject {
    
    var title:String?
    var images:[GalleryImage]?
    var subItems:[Gallery]?
    
    override init() {
        super.init()
        self.setup()
    }
    
    init(galleryTitle:String) {
        super.init()
        self.setup()
        self.title = galleryTitle
    }
    
    private func setup() {
        self.images = []
        self.subItems = []
    }
    
    func addImage(image:GalleryImage) {
        self.images?.append(image)
    }
   
}
