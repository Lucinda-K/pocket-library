//
//  Book.swift
//  PocketLibrary
//
//  Created by Lucinda Krahl on 4/11/16.
//  Copyright © 2016 Lucinda Krahl. All rights reserved.
//

import Foundation
import UIKit        // for image

class Book {
    
    // Book information
    var id : String = ""
    var title : String = ""
    var subtitle : String?
    var authors : [String] = []
    var publisher : String?
    var publishedDate : NSDate?
    var publishedDateStr : String?
    var description : String?
    var pageCount : Int?
    var mainCategory : String?
    var categories : [String]?
    var language : String = ""
    var listPrice : Double?
    var retailPrice : Double?
    var averageRating : Double?
    var imageurl_thumbnail : String?
    
    // default to false
    var isFavorite : Bool = false
    var owned : Bool = false
    
    var notes : String?
    
    func parseJSON(json: JSON) {
        
        self.id = String(json["id"])
        self.title = String(json["volumeInfo"]["title"])
        self.subtitle = String(json["volumeInfo"]["subtitle"])
        for author in json["volumeInfo"]["authors"] {
            self.authors.append(String(author))
        }
        self.publisher = String(json["volumeInfo"]["publisher"])
        self.publishedDateStr = String(json["volumeInfo"]["publishedDate"])
        self.description = String(json["volumeInfo"]["description"])
        self.pageCount = Int(String(json["pageCount"]))
        
        //self.imageurl = "http://static.giantbomb.com/" + json["image"]["super_url"].stringValue
        
    }
    
    
    init(data: JSON) {
        print("Adding Book object")
        self.parseJSON(data)
        print("Name: \(self.title)")
    }
    
}