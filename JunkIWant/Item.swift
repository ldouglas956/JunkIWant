//
//  Item.swift
//  JunkIWant
//
//  Created by Lance Douglas on 5/18/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//

import Foundation
import CoreData


class Item: NSManagedObject {

	override func awakeFromInsert() {
		super.awakeFromInsert()
		
		self.dateCreated = NSDate()
		
	}

}
