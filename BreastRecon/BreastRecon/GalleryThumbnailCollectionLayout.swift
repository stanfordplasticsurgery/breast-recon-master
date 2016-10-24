//
//  GalleryThumbnailCollectionLayout.swift
//  BreastRecon
//
//  Created by Randall Nickerson on 10/29/14.
//  Copyright (c) 2014 Crane Style Labs. All rights reserved.
//

import UIKit

class GalleryThumbnailCollectionLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        self.scrollDirection = UICollectionViewScrollDirection.Horizontal
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
