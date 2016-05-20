//
//  ItemCell.swift
//  JunkIWant
//
//  Created by Lance Douglas on 5/19/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

	@IBOutlet weak var itemImage: UIImageView!
	@IBOutlet weak var title: UILabel!
	@IBOutlet weak var price: UILabel!
	@IBOutlet weak var details: UILabel!
	
	
	
	func configureCell(item: Item) {
		title.text = item.title
		price.text = "$\(item.price!)"
		details.text = item.details
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

// Items in CoreData
//@NSManaged var title: String?
//@NSManaged var details: String?
//@NSManaged var price: NSNumber?
//@NSManaged var dateCreated: NSDate?
//@NSManaged var store: NSManagedObject?
//@NSManaged var image: Image?
//@NSManaged var itemType: ItemType?