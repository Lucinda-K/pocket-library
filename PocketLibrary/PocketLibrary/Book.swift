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
    
    /*
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
 
        var publisherStr = String(json["volumeInfo"]["publisher"])
        var publishers = [Publisher]()
        
        let fetchRequest = NSFetchRequest(entityName: "Publisher")
        //let predicate = NSPredicate(format: "publisherName == %ld", )
        //Query for Publishers with exact name
        let predicate = NSPredicate(format: "publisherName == %@", publisherStr)
        
        fetchRequest.predicate = predicate
        do {
            
            if let fetchResults = try managedObjectContext!.executeFetchRequest(fetchRequest) as? [Publisher] {
                publishers = fetchResults
            }
        } catch {
            print("Error: \(error)")
        }
        
        print(publishers)
        
        
        
        
        
        //self.publisher = String(json["volumeInfo"]["publisher"])
        //self.publishedDateStr = String(json["volumeInfo"]["publishedDate"])
        //self.description = String(json["volumeInfo"]["description"])
        self.pageCount = Int(String(json["volumeInfo"]["pageCount"]))
        
        //self.imageurl = "http://static.giantbomb.com/" + json["image"]["super_url"].stringValue
        
    }
*/
    
    func addAuthor(author: String) {
        
        print("Adding author: \(author)")
        
        let authorEntityDescription = NSEntityDescription.entityForName("Author", inManagedObjectContext: self.managedObjectContext!)
        let newAuthor = NSManagedObject(entity: authorEntityDescription!, insertIntoManagedObjectContext: self.managedObjectContext) as? Author
        
        newAuthor?.authorName = author
        
        authors.insert(newAuthor!)
        authorStr = ""
        
        if authors.count > 1 {
            authorStr = authorStr! + ", "
        } else {
            for thisAuthor in authors {
                authorStr = authorStr! + thisAuthor.authorName!
            }
        }
        //let currentAuthorString = authorStr
        //print("current string: \(currentAuthorString)")
        //authorStr = currentAuthorString! + author
        //print("authorStr: \(authorStr)")
        //managedObjectContext?.save()
    }
    
    func getAuthorStr() -> String {
        var newAuthorStr = ""
        var authorCt = 1
        for author in authors {
            newAuthorStr = newAuthorStr + author.authorName!
            if authorCt < authors.count {
                newAuthorStr = newAuthorStr + ", "
            }
            authorCt+=1
        }
        
        return newAuthorStr
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("books")
    
    
    
}