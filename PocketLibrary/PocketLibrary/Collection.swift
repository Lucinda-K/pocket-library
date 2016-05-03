//
//  Collection.swift
//  PocketLibrary
//
//  Created by Admin on 4/13/16.
//  Copyright © 2016 Lucinda Krahl. All rights reserved.
//

import Foundation
import CoreData

class Collection: NSManagedObject {
    

    func addBook(book: Book) {
        print("Adding book: \(book.title)")
        
        
        //self.bookCollection.append(book as Book)
        
        let entityDescription = NSEntityDescription.entityForName("Book", inManagedObjectContext: self.managedObjectContext!)
        let newBook = NSManagedObject(entity: entityDescription!, insertIntoManagedObjectContext: self.managedObjectContext)
        
        newBook.setValue(book.title, forKey: "title")
        
        var collection = self.mutableSetValueForKey("bookCollection")
        collection.addObject(newBook)
        
        //books.append(book as Book)
        var currentCount = self.bookCount as! Int
        currentCount+=1
        self.bookCount?.setValue(currentCount, forKey: "bookCount")
        
        //bookCount = books.count
        print("New count: \(bookCount)")
    }
    
    func removeBook(book: Book) {
        //isbn = book
        //bookCount = books.count
    }
    
    func searchForBook(category: String, query: String) {
        
    }
    
}