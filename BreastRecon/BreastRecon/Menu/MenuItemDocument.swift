//
//  MenuItemDocument.swift
//  BreastRecon
//
//  Created by Chi Kwan on 11/6/14.
//  Copyright (c) 2014 Crane Style Labs. All rights reserved.
//

import Foundation

class MenuItemDocument: MenuItem {
    var html :HtmlDocument?
    var filename :String?
    
    private var configFileDocument :NSDictionary!
    
    override init(){
        super.init()        
    }
    
    init(data:String) {
        super.init()
        self.filename = data
        setupMenuItemDocument()
    }
    
    private func setupMenuItemDocument(){
        self.addHtmlDocument(HtmlDocument(filename: self.filename!))
    }
    
    func addHtmlDocument(htmlDocument: HtmlDocument){
        self.html = htmlDocument
    }
}

