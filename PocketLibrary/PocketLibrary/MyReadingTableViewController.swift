//
//  MyReadingTableViewController.swift
//  PocketLibrary
//
//  Created by Admin on 4/19/16.
//  Copyright © 2016 Lucinda Krahl. All rights reserved.
//

import UIKit
import CoreData

class MyReadingTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    
    
    
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var myCollection : Collection?
    var myBooks = [Book]()
    var readBooks = [Book]()
    var readingBooks = [Book]()
    var toReadBooks = [Book]()
    
    var fetchedResultsController: NSFetchedResultsController = NSFetchedResultsController()
    
    @IBAction func unwindToReadingViewController(segue: UIStoryboardSegue) {}

    //var myReading = Collection(name: "myReading", books: [], bookCount: 0)
    
    @IBAction func addBookActionSheet(sender: UIBarButtonItem) {
        
        
        // 1
        let optionMenu = UIAlertController(title: nil, message: "Add new book to Reading list", preferredStyle: .ActionSheet)
        
        // 2
        let barcodeAction = UIAlertAction(title: "Scan barcode", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("User chose: Scan barcode")
            self.performSegueWithIdentifier("ReadingToScanner", sender: self)
        })
        let manualAction = UIAlertAction(title: "Enter manually", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("User chose: Enter manually")
        })
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("User cancelled")
        })
        
        
        // 4
        optionMenu.addAction(barcodeAction)
        optionMenu.addAction(manualAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    func getFetchedResultController() -> NSFetchedResultsController {
        fetchedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }
    
    
    func taskFetchRequest() -> NSFetchRequest {
        
        let context = appDelegate.managedObjectContext
        let fetchRequest1 = NSFetchRequest(entityName: "Collection")
        
        let collectionName = "myReading"
        let predicate = NSPredicate(format: "collectionName == %@", collectionName)
        fetchRequest1.predicate = predicate
        let sortDescriptor = NSSortDescriptor(key: "collectionName", ascending: true)
        fetchRequest1.sortDescriptors = [sortDescriptor]
        
        do {
            
            if let fetchResults = try context.executeFetchRequest(fetchRequest1) as? [Collection] {
                if fetchResults.count == 0 {
                    print("Creating new collection: \(collectionName)")
                    let collection = NSEntityDescription.entityForName("Collection", inManagedObjectContext: context)
                    let newCollection = NSManagedObject(entity: collection!, insertIntoManagedObjectContext: context)
                    newCollection.setValue(collectionName, forKey: "collectionName")
                    myCollection = newCollection as? Collection
                }
                else {
                    myCollection = fetchResults[0]
                }
                //print(myCollection?.collectionName)
            }
        } catch {
            print("Error: \(error)")
        }
        
        
        
        
        //let fetchRequest = NSFetchRequest(entityName: "Collection")
        
        return fetchRequest1
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Unwind and cancel segues
        //@IBAction func cancelToReadingViewController(segue: UIStoryboardSegue) {}
        
        //@IBAction func unwindToLibraryViewController(segue: UIStoryboardSegue) {}
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        
        // Create default data
        let collectionEntityDescription = NSEntityDescription.entityForName("Collection", inManagedObjectContext: self.managedObjectContext)
        let newCollection = NSManagedObject(entity: collectionEntityDescription!, insertIntoManagedObjectContext: self.managedObjectContext) as? Collection
        
        newCollection?.collectionName = "myReading"
        
        do {
            try newCollection!.managedObjectContext?.save()
        } catch {
            print(error)
        }
        
        
        
        fetchedResultsController = getFetchedResultController()
        //fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch _ {
        }
        

        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        tableView.reloadData()
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        
        fetchedResultsController = getFetchedResultController()
        //fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch _ {
        }
        

        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        let numberOfSections = fetchedResultsController.sections?.count
        return numberOfSections!
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return myReading!.bookCount
        let numberOfRowsInSection = myCollection?.bookCollection?.count
        return numberOfRowsInSection!
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReadingCell", forIndexPath: indexPath) as! MyReadingTableViewCell

        // Configure the cell...
        //var book : Book
        
        myBooks.removeAll()
        for book in (myCollection?.bookCollection)! {
            myBooks.append(book)
        }
        let current_book = myBooks[indexPath.row]
        //book = myReading!.books[indexPath.row]
        
        cell.titleLabel!.text = current_book.title
        //cell.authorLabel.text = book.authorStr
        
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ReadingToScanner" {
            if let scannerViewController = segue.destinationViewController as? ScannerViewController {
                let collection = self.myCollection
                scannerViewController.myCollection = collection
                print("SEGUE: Reading-->Scanner")
                print("Passing Collection - \(collection!.collectionName)")
            }
        }
        
        
    }
    

}
