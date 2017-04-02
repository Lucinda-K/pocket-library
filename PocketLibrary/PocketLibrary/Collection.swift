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
    

    func addBook(_ book: Book) {
        print("Adding book: \(book.title)")
        
        
        //self.bookCollection.append(book as Book)
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Book", in: self.managedObjectContext!)
        let newBook = NSManagedObject(entity: entityDescription!, insertInto: self.managedObjectContext)
        
        newBook.setValue(book.title, forKey: "title")
        
        let collection = self.mutableSetValue(forKey: "bookCollection")
        collection.add(newBook)
        
        //books.append(book as Book)
        var currentCount = self.bookCount as! Int
        currentCount+=1
        self.bookCount?.setValue(currentCount, forKey: "bookCount")
        
        //bookCount = books.count
        print("New count: \(bookCount)")
    }
    
    func removeBook(_ book: Book) {
        //isbn = book
        //bookCount = books.count
    }
    
    func searchForBook(_ category: String, query: String) {
        
    }
    
}
