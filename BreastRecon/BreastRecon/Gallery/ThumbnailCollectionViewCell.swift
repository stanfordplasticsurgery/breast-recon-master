//
//  ThumbnailCollectionViewCell.swift
//  BreastRecon
//
//  Created by Randall Nickerson on 10/29/14.
//  Copyright (c) 2014 Crane Style Labs. All rights reserved.
//

import UIKit

class ThumbnailCollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: frame.size.width - 20, height: frame.size.height - 20))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        contentView.backgroundColor = AppConfig.sharedInstance.thumbnail_border()
        contentView.addSubview(imageView)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}