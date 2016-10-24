//
//  BorderedWebView.swift
//  BreastRecon
//
//  Created by Dan Hoffman on 1/16/15.
//  Copyright (c) 2015 Crane Style Labs. All rights reserved.
//

import UIKit

class BorderedWebView: UIWebView, UIScrollViewDelegate {

    var topBorder    = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 0, height: 0)))
    var bottomBorder = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 100, height: 100)))

    override init() {
        super.init()
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        self.scrollView.delegate = self
        topBorder.backgroundColor    = AppConfig.sharedInstance.imageBorder_background()
        bottomBorder.backgroundColor = AppConfig.sharedInstance.imageBorder_background()

        topBorder.frame.size    = CGSize(width: self.frame.width, height: 0)
        bottomBorder.frame.size = CGSize(width: self.frame.width, height: 0)

        bottomBorder.frame.origin = CGPoint(x: 0, y: self.frame.size.height)

        self.addSubview(topBorder)
        self.addSubview(bottomBorder)
    }

    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if (scrollView.contentOffset.y < 0) {
            topBorder.frame.size = CGSize(width: topBorder.frame.size.width, height: -scrollView.contentOffset.y)
        } else if (scrollView.contentOffset.y > 0) {
            bottomBorder.frame.origin = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.contentOffset.y)
            bottomBorder.frame.size   = CGSize(width: bottomBorder.frame.size.width, height: scrollView.contentOffset.y)
        }
    }

   
}
