//
//  AddItemVC.swift
//  JunkIWant
//
//  Created by Lance Douglas on 5/19/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//

import UIKit
import CoreData

class AddItemVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
	
	@IBOutlet weak var storePicker: UIPickerView!
	@IBOutlet weak var titleField: UITextField!
	@IBOutlet weak var priceField: UITextField!
	@IBOutlet weak var detailsField: UITextView!
	
	var stores = [Store]()
	var itemToEdit: Item?

    override func viewDidLoad() {
        super.viewDidLoad()
		
		storePicker.delegate = self
		storePicker.dataSource = self
		
		getStores()
		if (stores.count == 0) {
			loadTestStores()
			getStores()
		}
		
		if itemToEdit != nil {
			loadItemData()
		}

    }
	
	func loadTestStores() {
		let store1 = NSEntityDescription.insertNewObjectForEntityForName("Store", inManagedObjectContext: ad.managedObjectContext) as! Store
		let store2 = NSEntityDescription.insertNewObjectForEntityForName("Store", inManagedObjectContext: ad.managedObjectContext) as! Store
		let store3 = NSEntityDescription.insertNewObjectForEntityForName("Store", inManagedObjectContext: ad.managedObjectContext) as! Store
		let store4 = NSEntityDescription.insertNewObjectForEntityForName("Store", inManagedObjectContext: ad.managedObjectContext) as! Store
		let store5 = NSEntityDescription.insertNewObjectForEntityForName("Store", inManagedObjectContext: ad.managedObjectContext) as! Store
		let store6 = NSEntityDescription.insertNewObjectForEntityForName("Store", inManagedObjectContext: ad.managedObjectContext) as! Store
		
		store1.name = "Amazon"
		store2.name = "Walmart"
		store3.name = "Revzilla"
		store4.name = "Best Buy"
		store5.name = "Eddie Bauer"
		store6.name = "Banana Republic"
		
		ad.saveContext()
	}
	

	func getStores() {
		let fetchRequest = NSFetchRequest(entityName: "Store")
		
		do {
			self.stores = try ad.managedObjectContext.executeFetchRequest(fetchRequest) as! [Store]
			self.storePicker.reloadAllComponents()
		} catch {
			print("\(error)")
		}
	}
	
	
	@IBAction func savePressed(sender: UIButton) {
		
		var item: Item!
		
		if itemToEdit == nil {
			item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: ad.managedObjectContext) as! Item
		} else {
			item = itemToEdit
		}
		
		if titleField.text != "" {
			if let title = titleField.text {
				item.title = title
			}
			
			if let price = priceField.text {
				let priceStr = NSString(string: price)
				let priceDbl = priceStr.doubleValue
				item.price = NSNumber(double: priceDbl)
			}
			
			if let details = detailsField.text {
				item.details = details
			}
			
			item.store = stores[storePicker.selectedRowInComponent(0)]
			
			ad.saveContext()
			self.navigationController?.popViewControllerAnimated(true)
		}
	}
	
	
	
	@IBAction func deletePressed() {
		if itemToEdit != nil {
			areYouSureAlert()
		}
	}
	
	func areYouSureAlert() {
		let alertController = UIAlertController(title: "Delete?", message: "", preferredStyle: .Alert)
		
		let firstAction = UIAlertAction(title: "Keep It", style: UIAlertActionStyle.Default, handler: nil)
		let secondAction = UIAlertAction(title: "Delete It", style: UIAlertActionStyle.Destructive, handler: { action in
			self.deleteItem()
			self.navigationController?.popViewControllerAnimated(true) } )
		
		alertController.addAction(firstAction)
		alertController.addAction(secondAction)
		self.presentViewController(alertController, animated: true, completion: {})
	}
	
	func deleteItem() {
		ad.managedObjectContext.deleteObject(itemToEdit!)
		ad.saveContext()
	}
	
	
	func loadItemData() {
		if let item = itemToEdit {
			if let title = item.title {
				titleField.text = title
			}
			if let price = item.price {
				priceField.text = "\(price)"
			}
			if let details = item.details {
				detailsField.text = details
			}
			if let store = item.store {
				var index = 0
				repeat {
					let s = stores[index]
					
					if s.name == store.name {
						storePicker.selectRow(index, inComponent: 0, animated: false)
						break
					}
					index += 1
				} while (index < stores.count)
			}
		}
	}
	
	
	// MARK: PICKER VIEW BOILERPLATE
	func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return stores.count
	}
	
	func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		let store = stores[row]
		return store.name
	}
	
	func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//		print(row)
		
		
	}


}
