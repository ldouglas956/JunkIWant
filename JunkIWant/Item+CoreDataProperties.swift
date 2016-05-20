//
//  Item+CoreDataProperties.swift
//  JunkIWant
//
//  Created by Lance Douglas on 5/18/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Item {

    @NSManaged var title: String?
    @NSManaged var details: String?
    @NSManaged var price: NSNumber?
    @NSManaged var dateCreated: NSDate?
    @NSManaged var store: Store? // Changed from NSManagedObject? which was the default
    @NSManaged var image: Image?
    @NSManaged var itemType: ItemType?

}
