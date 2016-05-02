//
//  Author+CoreDataProperties.swift
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

extension Author {

    @NSManaged var authorName: String?
    @NSManaged var authoredBooks: NSSet?

}
