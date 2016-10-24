//
//  Documentation.swift
//  BreastRecon
//
//  Created by Randall Nickerson on 10/31/14.
//  Copyright (c) 2014 Crane Style Labs. All rights reserved.
//

import UIKit

class Documentation: NSObject {
    var title: String?
    var html:HtmlDocument?
    
    override init() {
        super.init()
    }
    
    init(configFile:String){
        super.init()
    }
    
    func addHtmlDocument(htmlDocument: HtmlDocument){
        self.html = htmlDocument
    }
}
