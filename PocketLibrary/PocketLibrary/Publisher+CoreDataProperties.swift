//
//  Publisher+CoreDataProperties.swift
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

extension Publisher {

    @NSManaged var publisherName: String?
    @NSManaged var bookPublished: NSSet?

}
