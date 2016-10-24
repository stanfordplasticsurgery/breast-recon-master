//
//  HtmlDocument.swift
//  BreastRecon
//
//  Created by Randall Nickerson on 10/31/14.
//  Copyright (c) 2014 Crane Style Labs. All rights reserved.
//

import UIKit

class HtmlDocument: NSObject {

    var filename:String!
    var filetype:String!
    var documentPath: String!
    
    let kFilenameIndex:Int = 0
    let kFileTypeIndex:Int = 1
    
    override init(){
        super.init()
    }
    
    init(filename: String, documentPath: String){
        super.init()
        let separator: String = "/"
        
        let filenameTokens:[String] = self.breakdownFilename(filename)
        self.filename = filenameTokens[kFilenameIndex]
        self.filetype = filenameTokens[kFileTypeIndex]

        if documentPath.hasSuffix(separator){
            self.documentPath = documentPath.substringToIndex(documentPath.endIndex.predecessor())
        } else {
            self.documentPath = documentPath
        }
    }
    
    init(filename: String){
        super.init()
        let separator: String = "/"

        let filenameTokens:[String] = self.breakdownFilename(filename)
        self.filename = filenameTokens[kFilenameIndex]
        self.filetype = filenameTokens[kFileTypeIndex]
        
        self.documentPath = AppConfig.sharedInstance.getDocumentPath()
        
        let appConfigDocumentPath = AppConfig.sharedInstance.getDocumentPath()
        if appConfigDocumentPath.hasSuffix(separator){
            self.documentPath = appConfigDocumentPath.substringToIndex(appConfigDocumentPath.endIndex.predecessor())
        } else {
            self.documentPath = appConfigDocumentPath
        }
    }
    
    func getFullPath()-> String{
        let bundle = NSBundle.mainBundle()
        if let path = bundle.pathForResource(self.filename, ofType: self.filetype, inDirectory: self.documentPath){
            return path
        } else {
            NSException(name: "PathNotFound", reason: "\(self.filename) : no such file", userInfo: nil).raise()
            return ""
        }
    }
    
    func getNSURLRequest()->NSURLRequest {
        let url:NSURL = NSURL(fileURLWithPath: self.getFullPath())!
        return NSURLRequest(URL: url)
    }
    
    func breakdownFilename(filename:String) -> [String] {
        let path = filename.lastPathComponent
        var name:String = path
        var type:String = ""
        var sep:String = "."
        var tokens:[String] = name.componentsSeparatedByString(sep)
        if tokens.count > 1 {
            type = tokens.removeLast()
            name = sep.join(tokens)
        }
        return [name, type]
    }
    
}
