//
//  Collection.swift
//  PocketLibrary
//
//  Created by Admin on 4/13/16.
//  Copyright © 2016 Lucinda Krahl. All rights reserved.
//

import Foundation


class Collection: NSObject, NSCoding {
    
    var name : String
    var books : [Book] = []   // list of Book objects
    var bookCount : Int = 0
    var pageTotal : Int = 0
    var priceTotal : Double = 0.0
    
    func addBook(book: Book) {
        print("Adding book: \(book.title)")
        books.append(book)
        bookCount = books.count
        print("New count: \(bookCount)")
    }
    
    func removeBook(book: Book) {
        //isbn = book
        bookCount = books.count
    }
    
    func searchForBook(category: String, query: String) {
        
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("collection")
    
    
    // MARK: Properties
    
    struct PropertyKey {
        static let nameKey = "name"
        static let booksKey = "books"
        static let bookCountKey = "bookCount"
    }
    
    // MARK: NSCoding
    
    
    //https://developer.apple.com/library/ios/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Lesson10.html
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(books, forKey: PropertyKey.booksKey)
        aCoder.encodeObject(bookCount, forKey: PropertyKey.bookCountKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let books = aDecoder.decodeObjectForKey(PropertyKey.booksKey) as! [Book]
        let bookCount = aDecoder.decodeObjectForKey(PropertyKey.booksKey) as! Int
        
        // Must call designated initializer
        
        self.init(name: name, books: books, bookCount: bookCount)
        
    }
    
    init?(name: String, books: [Book], bookCount: Int) {
        
        // Initialize stored properties
        self.name = name
        self.books = books
        self.bookCount = bookCount
        
        super.init()
        
        // Initialization should fail if there is no name
        if name.isEmpty {
            return nil
        }
    }
    
}