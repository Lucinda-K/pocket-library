//
//  GoogleBooksService.swift
//  PocketLibrary
//
//  Created by Lucinda Krahl on 4/4/16.
//  Copyright © 2016 Lucinda Krahl. All rights reserved.
//

import Foundation

class GoogleBooksService {
    
    var API_KEY : String
    var books : [JSON] = []
    var titleArray : [String] = []
    
    var resultJSON : String = ""
    
    func parseJSONResponse( data: NSData) -> Void {
        
        
        let json = JSON(data: data)
        
        if json["items"].count == 0 {
            print("Not a book barcode")
            
        }
        
        for(_, book) in json["items"] {
            print("Adding a book")
            books.append(book)
        }

        
    }
    
    
    
    func queryByISBN(isbn: String, callback: ([JSON]) -> Void) {
        // Modeled off of assignment 4 API request
        print("Querying...")
        // Create query url
        let url_str = "https://www.googleapis.com/books/v1/volumes?q=isbn:\(isbn)&key=\(self.API_KEY)"

        print(url_str)
        
        let url2 = NSURL(string: url_str)
        let request = NSMutableURLRequest(URL: url2!)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request) {
            
            (data, responseText, error) -> Void in if error != nil {
                print(error)
            } else {
                
                let result = String(data: data!, encoding: NSASCIIStringEncoding)!
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    self.resultJSON = result
                    
                    self.parseJSONResponse(data!)
                    
                    callback(self.books)
                })
            }
        }
        
        task.resume()
        
        
    }
    
    init(API_KEY: String) {
        self.API_KEY = API_KEY
        
    }
    
    
}