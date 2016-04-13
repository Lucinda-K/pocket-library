//
//  Collection.swift
//  PocketLibrary
//
//  Created by Admin on 4/13/16.
//  Copyright © 2016 Lucinda Krahl. All rights reserved.
//

import Foundation


class Collection {
    
    
    var library : [Book] = []   // list of Book objects
    var bookCount : Int = 0
    var pageTotal : Int = 0
    var priceTotal : Double = 0.0
    
    func addBook(book: Book) {
        library.append(book)
    }
    
    func removeBook(book: Book) {
        //isbn = book
    }
    
    func searchForBook(category: String, query: String) {
        
    }
    
    init() {
        
    }
    
}