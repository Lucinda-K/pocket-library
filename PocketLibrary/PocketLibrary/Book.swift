//
//  Book.swift
//  PocketLibrary
//
//  Created by Lucinda Krahl on 4/11/16.
//  Copyright © 2016 Lucinda Krahl. All rights reserved.
//

import Foundation
import UIKit        // for image
import CoreData

class Book: NSManagedObject {
    
    // Book information
    /*
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
    //var description : String?
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
    */
    
    
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
        //self.description = String(json["volumeInfo"]["description"])
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
    
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("books")
    
    
    // MARK: Properties
    
    struct PropertyKey {
        
        static let idKey = "id"
        static let isbnKey = "isbn"
        static let titleKey = "title"
        static let subtitleKey = "subtitle"
        static let authorKey = "author"
        static let authorsKey = "authors"
        static let authorStrKey = "authorStr"
        static let publisherKey = "publisher"
        static let publishedDateKey = "publishedDate"
        static let publishedDateStrKey = "publishedDateStr"
        //static let descriptionKey = "description"
        static let pageCountKey = "pageCount"
        static let mainCategoryKey = "mainCategory"
        static let categoriesKey = "categories"
        static let languageKey = "language"
        static let listPriceKey = "listPrcie"
        static let retailPriceKey = "retailPrice"

    }
    
    // MARK: NSCoding
    
    
    //https://developer.apple.com/library/ios/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Lesson10.html
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(id, forKey: PropertyKey.idKey)
        aCoder.encodeObject(isbn, forKey: PropertyKey.isbnKey)
        aCoder.encodeObject(title, forKey: PropertyKey.titleKey)
        aCoder.encodeObject(subtitle, forKey: PropertyKey.subtitleKey)
        aCoder.encodeObject(author, forKey: PropertyKey.authorKey)
        aCoder.encodeObject(authors, forKey: PropertyKey.authorsKey)
        aCoder.encodeObject(authorStr, forKey: PropertyKey.authorStrKey)
        aCoder.encodeObject(publisher, forKey: PropertyKey.publisherKey)
        aCoder.encodeObject(publishedDate, forKey: PropertyKey.publishedDateKey)
        aCoder.encodeObject(publishedDateStr, forKey: PropertyKey.publishedDateStrKey)
        //aCoder.encodeObject(description, forKey: PropertyKey.descriptionKey)
        aCoder.encodeObject(pageCount, forKey: PropertyKey.pageCountKey)
        aCoder.encodeObject(mainCategory, forKey: PropertyKey.mainCategoryKey)
        aCoder.encodeObject(categories, forKey: PropertyKey.categoriesKey)
        aCoder.encodeObject(language, forKey: PropertyKey.languageKey)
        aCoder.encodeObject(listPrice, forKey: PropertyKey.listPriceKey)
        aCoder.encodeObject(retailPrice, forKey: PropertyKey.retailPriceKey)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        //let id = aDecoder.decodeObjectForKey(PropertyKey.idKey) as! String
        //let isbn = aDecoder.decodeObjectForKey(PropertyKey.isbnKey) as! String
        let title = aDecoder.decodeObjectForKey(PropertyKey.titleKey) as! String
        //let subtitle = aDecoder.decodeObjectForKey(PropertyKey.subtitleKey) as? String
        //let author = aDecoder.decodeObjectForKey(PropertyKey.authorKey) as! String
        let authors = aDecoder.decodeObjectForKey(PropertyKey.authorsKey) as! [String]
        //let authorStr = aDecoder.decodeObjectForKey(PropertyKey.authorStrKey) as! String
        //let publisher = aDecoder.decodeObjectForKey(PropertyKey.publisherKey) as? String
        //let publishedDate = aDecoder.decodeObjectForKey(PropertyKey.publishedDateKey) as? NSDate
        //let publishedDateStr = aDecoder.decodeObjectForKey(PropertyKey.publishedDateStrKey) as? String
        //let description = aDecoder.decodeObjectForKey(PropertyKey.descriptionKey) as? String
        //let pageCount = aDecoder.decodeObjectForKey(PropertyKey.pageCountKey) as? Int
        //let mainCategory = aDecoder.decodeObjectForKey(PropertyKey.mainCategoryKey) as? String
        //let categories = aDecoder.decodeObjectForKey(PropertyKey.categoriesKey) as? [String]
        //let language = aDecoder.decodeObjectForKey(PropertyKey.languageKey) as! String
        //let listPrice = aDecoder.decodeObjectForKey(PropertyKey.listPriceKey) as? Double
        //let retailPrice = aDecoder.decodeObjectForKey(PropertyKey.retailPriceKey) as? Double
        
        
        
        // Must call designated initializer
        
        self.init(title: title, authors: authors)
        
    }
    
    init?(data: JSON) {
        print("Adding Book object")
        
        super.init()
        
        self.parseJSON(data)
        print("Name: \(self.title)")
    }
    
    init?(title: String, authors: [String]) {
        
        self.title = title
        self.authors = authors


        super.init()
        
        for newAuthor in authors {
            self.addAuthor(newAuthor)
        }
        
        // Initialization should fail if there is no name
        if title.isEmpty {
            return nil
        }

    }
    
    
    
}