//
//  ApiKeys.swift
//  PocketLibrary
//
//  Created by Lucinda Krahl on 4/6/16.
//  Copyright © 2016 Lucinda Krahl. All rights reserved.
//

import Foundation

// http://dev.iachieved.it/iachievedit/using-property-lists-for-api-keys-in-swift-applications/

func valueForAPIKey(keyname property: String) -> String {
    let filePath = Bundle.main.path(forResource: "ApiKeys", ofType:"plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    
    let value:String = plist?.object(forKey: property) as! String
    return value
}
