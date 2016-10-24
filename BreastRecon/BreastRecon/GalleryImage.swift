//
//  GalleryImage.swift
//  BreastRecon
//
//  Created by Randall Nickerson on 10/31/14.
//  Copyright (c) 2014 Crane Style Labs. All rights reserved.
//

import UIKit

enum GalleryItemType {
    case Image
    case Document
}

class GalleryImage: NSObject {
    
    var thumbnail:UIImage?
    var fullsize:UIImage?
    var details:String?
    var title: String?
    var itemType: GalleryItemType = GalleryItemType.Image
    var html :HtmlDocument?

    override init() {
        super.init()
    }
    
    init(thumbnailImage:UIImage, fullsizeImage:UIImage) {
        super.init()
        self.thumbnail = thumbnailImage
        self.fullsize = fullsizeImage
    }
    
    init(configFileImage: NSDictionary){
        super.init()
        let keyThumbnail = "thumbnail"
        let keyFullSize = "fullsize"
        let keyDetails = "details"
        let keyTitle = "title"
        let keyType = "type"
        let ext:String = "png"
        
        let filenameFullsize = configFileImage[keyFullSize] as String
        let filenameThumbnail = configFileImage[keyThumbnail] as String
        
        let pathFullSize = AppConfig.sharedInstance.getFullSizePath()
        let pathThumbnail = AppConfig.sharedInstance.getThumbnailPath()
        
        self.thumbnail = UIImage(named: "\(pathThumbnail)/\(filenameThumbnail).\(ext)")
        self.fullsize = UIImage(named: "\(pathFullSize)/\(filenameFullsize).\(ext)")
        self.details = configFileImage[keyDetails] as String?
        self.title = configFileImage[keyTitle] as String?

        if let typeString = configFileImage[keyType] as String? {
            if typeString == "document" {
                self.itemType = GalleryItemType.Document
                self.html = HtmlDocument(filename: filenameFullsize)
            }
        }
    }
}

