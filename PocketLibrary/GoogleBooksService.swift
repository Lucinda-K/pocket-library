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
    var json_books : [JSON] = []
    var titleArray : [String] = []
    
    var resultJSON : String = ""
    
    func parseJSONResponse( _ data: Data) -> Void {
        
        
        let json = JSON(data: data)
        
        if json["items"].count == 0 {
            print("Not a book barcode")
            
        }
        
        for(_, book) in json["items"] {
            print("Adding a book")
            json_books.append(book)
        }

        
    }
    
    
    
    func queryByISBN(_ isbn: String, callback: @escaping ([JSON]) -> Void) {
        // Modeled off of assignment 4 API request
        print("Querying...")
        // Create query url
        let url_str = "https://www.googleapis.com/books/v1/volumes?q=isbn:\(isbn)&key=\(self.API_KEY)"

        print(url_str)
        
        let url2 = URL(string: url_str)
        let request = NSMutableURLRequest(url: url2!)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: {
            
            (data, responseText, error) -> Void in if error != nil {
                print(error)
            } else {
                
                let result = String(data: data!, encoding: String.Encoding.ascii)!
                
                DispatchQueue.main.async(execute: {
                    
                    self.resultJSON = result
                    
                    self.parseJSONResponse(data!)
                    
                    callback(self.json_books)
                })
            }
        }) 
        
        task.resume()
        
        
    }
    
    init(API_KEY: String) {
        self.API_KEY = API_KEY
        
    }
    
    
}
