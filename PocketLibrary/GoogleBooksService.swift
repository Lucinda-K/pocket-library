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
        
        //print("Printing data")
        //print(data)
        
        //var authors : [JSON] = []
        
        let json = JSON(data: data)
        
        for(_, book) in json["items"] {
            print("Adding a book")
            books.append(book)
        }
        /*
        let title = json["items"]["volumeInfo"]["title"]
        print("Printing title")
        print(title)
        for (_, author) in json["items"]["volumeInfo"]["authors"] {
            print("Printing author")
            print(author)
            authors.append(author)
        }*/
        
    }
    
    
    
    func queryByISBN(isbn: String, callback: ([JSON]) -> Void) {
        // Modeled off of assignment 4 API request
        print("Querying...")
        // Create query url
        let url_str = "https://www.googleapis.com/books/v1/volumes?q=isbn:\(isbn)&key=\(self.API_KEY)"
        
       // var arrayOfTitles: [String] = []
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
        
        /*
        if let url = NSURL(string: url_str) {
            NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {data, _, error -> Void in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if let data = data,
                        jsonResult = try? NSJSONSerialization.JSONObjectWithData(data, options: []),
                        titleArray = jsonResult.valueForKeyPath("items.volumeInfo.title") as? [String] {
                            let titles = titleArray.joinWithSeparator(", ")
                            print("Titles: \(titles)")
                            print("Retrieved data")
                    } else {
                        // error
                        print("error: data")
                    }
                }
            }).resume()
            sleep(2)
            print("Continue")

        }

        return titleArray
    */
        
    }
    
    init(API_KEY: String) {
        self.API_KEY = API_KEY
        
    }
    
    
    
    
}