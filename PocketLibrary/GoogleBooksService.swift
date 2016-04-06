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
        print("Querying...")
        // Create query url
        let url_str = "https://www.googleapis.com/books/v1/volumes?q=isbn:\(isbn)&key=\(self.API_KEY)"
        
        
        print(url_str)
        
        if let url = NSURL(string: url_str) {
            NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {data, _, error -> Void in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if let data = data,
                        jsonResult = try? NSJSONSerialization.JSONObjectWithData(data, options: []),
                        arrayOfTitles = jsonResult.valueForKeyPath("items.volumeInfo.title") as? [String] {
                            let titles = arrayOfTitles.joinWithSeparator(", ")
                            print("Titles: \(titles)")
                            print("Retrieved data")
                    } else {
                        // error
                        print("error: data")
                    }
                }
            }).resume()
            print("Continue")
        }


        
    }
    
    init(API_KEY: String) {
        self.API_KEY = API_KEY
        
    }
    
    
    
    
}