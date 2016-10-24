//
//  DataFileObject.swift
//  BreastRecon
//
//  Created by Randall Nickerson on 1/12/15.
//  Copyright (c) 2015 Crane Style Labs. All rights reserved.
//

import UIKit

class DataFileObject: NSObject {
    
    var data:NSDictionary!
    
    init(dataFile: String){
        super.init()
        data = self.readConfigFile(dataFile)
    }
    
    private func readConfigFile(dataFilename:String) -> NSDictionary{
        let filetype:String = "plist"
        var dataFile:NSDictionary = NSDictionary()
        if let dataFilePath = NSBundle.mainBundle().pathForResource(dataFilename, ofType: filetype) {
            dataFile = NSMutableDictionary(contentsOfFile: dataFilePath)!
        }
        return dataFile
    }
   
}
