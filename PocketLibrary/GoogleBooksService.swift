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
    
    var resultJSON : String = ""
    
    func parseJSONResponse( data: NSData) -> Void {
        var title: JSON = ""
        var authors: [JSON] = []
        let json = JSON(data: data)
        
        title = json["items"]["volumeInfo"]["title"]
        for (_, author) in json["items"]["volumeInfo"]["authors"] {
            authors.append(author)
        }
        
    }
    
    func queryByISBN(isbn: String, callback: ([JSON]) -> Void) {
        // Modeled off of assignment 4 API request
        
        // Create query url
        let url_str = "https://www.googleapis.com/books/v1/volumes?q=isbn:\(isbn)&key=\(self.API_KEY)"
        
        
        print(url_str)
        
        let url = NSURL(string: url_str)
        let request = NSMutableURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        
        
        let task = session.dataTaskWithRequest(request) {
            (data, responseText, error) -> Void in if error != nil {
                print(error)
            } else {
                
                let result = String(data: data!, encoding: NSASCIIStringEncoding)!
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    
                    self.resultJSON = result
                    //                    let json = JSON(data: data!)
                    
                    self.parseJSONResponse(data!)
                    //                    for (_, console) in json["results"] {
                    //                        self.platforms.append(console)
                    //                    }
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