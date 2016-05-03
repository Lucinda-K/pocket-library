//
//  Book+CoreDataProperties.swift
//  PocketLibrary
//
//  Created by Lucinda Krahl on 5/2/16.
//  Copyright © 2016 Lucinda Krahl. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Book {

    @NSManaged var title: String
    @NSManaged var authorStr: String?
    @NSManaged var id: String?
    @NSManaged var isbn: String?
    @NSManaged var subtitle: String?
    @NSManaged var publishedDateStr: String?
    @NSManaged var language: String?
    @NSManaged var pageCount: NSNumber?
    @NSManaged var listPrice: NSNumber?
    @NSManaged var retailPrice: NSNumber?
    @NSManaged var notes: String?
    @NSManaged var imageUrl: String?
    @NSManaged var collection: Collection?
    @NSManaged var authors: Set<Author>
    @NSManaged var publisher: Publisher?
    @NSManaged var categories: NSSet?
    @NSManaged var mainCategory : String?

}
