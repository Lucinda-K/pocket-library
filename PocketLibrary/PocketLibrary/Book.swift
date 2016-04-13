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
    var isbn: String = ""
    var title : String = ""
    var subtitle : String?
    var author : String = ""
    var authors : [String] = []
    var authorStr : String = ""
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
    var list : [String] = ["1","2","3"]

    
    var notes : String?
    
    func parseJSON(json: JSON) {
        
        var isbns : [String] = []
        
        self.id = String(json["id"])
        
        for i in 0...json["volumeInfo"]["industryIdentifiers"].count-1 {
            isbns.append(json["volumeInfo"]["industryIdentifiers"][i]["identifier"].stringValue)
        }
        //print(isbns)
        self.isbn = isbns[1]
        print(self.isbn)
        //isbns = json["volumeInfo"]["industryIdentifiers"]
        //print(json["volumeInfo"]["industryIndentifiers"])
        
        self.isbn = String(json["volumeInfo"]["industryIdentifiers"])
        self.title = String(json["volumeInfo"]["title"])
        self.subtitle = String(json["volumeInfo"]["subtitle"])
        
        for index in 0...json["volumeInfo"]["authors"].count-1 {
            // Add each author to object
            addAuthor(json["volumeInfo"]["authors"][index].stringValue)
        }
 
        self.publisher = String(json["volumeInfo"]["publisher"])
        self.publishedDateStr = String(json["volumeInfo"]["publishedDate"])
        self.description = String(json["volumeInfo"]["description"])
        self.pageCount = Int(String(json["volumeInfo"]["pageCount"]))
        
        //self.imageurl = "http://static.giantbomb.com/" + json["image"]["super_url"].stringValue
        
    }
    
    func addAuthor(author: String) {
        //print("Adding author \(self.authors.count): \(author)")
        // Add author to list
        self.authors.append(author)
        // Add to author string (only include comma if more than 1 author)
        if self.authors.count > 1 {
            self.authorStr = self.authorStr + ", "
        }
        self.authorStr = self.authorStr + author
        //print("New author list: \(self.authors)")
        //print("New author string: \(self.authorStr)")
    }
    
    init(data: JSON) {
        print("Adding Book object")
        self.parseJSON(data)
        print("Name: \(self.title)")
    }
    
}