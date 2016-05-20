//
//  ViewController.swift
//  JunkIWant
//
//  Created by Lance Douglas on 5/18/16.
//  Copyright © 2016 Lance Douglas. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var segment: UISegmentedControl!
	
	var fetchedResultsController: NSFetchedResultsController!


	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
		
//		generateTestData()
		attemptFetch()
	}
	
	
	// MARK: CORE DATA BOILERPLATE CODE
	
	func attemptFetch() {
		setFetchedResults()
		
		do {
			try self.fetchedResultsController.performFetch()
		} catch {
			let error = error as NSError
			print("\(error), \(error.userInfo)")
		}
	}
	
	func setFetchedResults() {
		let section: String? = segment.selectedSegmentIndex == 1 ? "store.name" : nil // from generated Item and Store relationship
		let fetchRequest = NSFetchRequest(entityName: "Item")
		let sortDescriptor = NSSortDescriptor(key: "dateCreated", ascending: true)
		fetchRequest.sortDescriptors = [sortDescriptor]
		
		let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: ad.managedObjectContext, sectionNameKeyPath: section, cacheName: nil)
		controller.delegate = self
		fetchedResultsController = controller
	}
	
	func controllerWillChangeContent(controller: NSFetchedResultsController) {
		tableView.beginUpdates()
	}
	
	func controllerDidChangeContent(controller: NSFetchedResultsController) {
		tableView.endUpdates()
	}
	
	func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
		
		switch(type) {
		case .Insert:
			if let indexPath = newIndexPath {
				tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
			}; break
		case .Delete:
			if let indexPath = indexPath {
				tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
			}; break
		case .Update:
			if let indexPath = indexPath {
				let cell = tableView.cellForRowAtIndexPath(indexPath) as! ItemCell
				configureCell(cell, indexPath: indexPath)
			}; break
		case .Move:
			if let indexPath = indexPath {
				tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
			}
			if let newIndexPath = newIndexPath {
				tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
			}; break
		}
		
	}
	
	
	// MARK: TABLE VIEW BOILERPLATE CODE
	// Item is a stored entity
	// ItemCell is a UITableViewCell class
	
	func configureCell(cell: ItemCell, indexPath: NSIndexPath) {
		if let item = fetchedResultsController.objectAtIndexPath(indexPath) as? Item {
			cell.configureCell(item)
		}
	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		if let sections = fetchedResultsController.sections {
			return sections.count
		}
		return 0
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let sections = fetchedResultsController.sections {
			let sectionInfo = sections[section]
			return sectionInfo.numberOfObjects
		}
		return 0
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as! ItemCell
		configureCell(cell, indexPath: indexPath)
		
		return cell
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 156
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		
		if let objs = fetchedResultsController.fetchedObjects where objs.count > 0 {
			let item = objs[indexPath.row] as! Item
			
			performSegueWithIdentifier("showItemDetailsVC", sender: item)
		}
	}
	
	
	// MARK: SEGUE
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "showItemDetailsVC" {
			let vc = segue.destinationViewController as! AddItemVC
			vc.itemToEdit = sender as? Item
		}
//		let backItem = UIBarButtonItem()
//		backItem.title = "Cancel"
//		navigationItem.backBarButtonItem = backItem
	}
	

	// MARK: TEST DATA
	func generateTestData() {
		
		let item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: ad.managedObjectContext) as! Item
		item.title = "Cool LEGO Set"
		item.price = 45.99
		item.details = "Star Wars Millenium Falcon!"
		
		let item2 = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: ad.managedObjectContext) as! Item
		item2.title = "Motorcycle Helmet"
		item2.price = 600.00
		item2.details = "I really don't need a second Shoei"
		
		ad.saveContext()
	}
	

	

}

