//
//  ItemType+CoreDataProperties.swift
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

extension ItemType {

    @NSManaged var type: String?
    @NSManaged var items: NSSet?

}
