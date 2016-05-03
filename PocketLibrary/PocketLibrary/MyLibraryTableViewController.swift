//
//  MyLibraryTableViewController.swift
//  PocketLibrary
//
//  Created by Lucinda Krahl on 4/18/16.
//  Copyright © 2016 Lucinda Krahl. All rights reserved.
//

import UIKit
import CoreData

class MyLibraryTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    var myCollection : Collection?
    var myBooks = [Book]()
    
    // Unwind segue from cancel button
    
    
    var fetchedResultsController: NSFetchedResultsController = NSFetchedResultsController()
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }
    
    override func canPerformUnwindSegueAction(action: Selector, fromViewController: UIViewController, withSender sender: AnyObject) -> Bool {
        if self.respondsToSelector(action){
            return true
        } else {
            return false
        }
        
    }


    
    @IBAction func addBookActionSheet(sender: UIBarButtonItem) {
        print("User clicked + from Reading")
        
        // 1
        let optionMenu = UIAlertController(title: nil, message: "Add new book to Reading list", preferredStyle: .ActionSheet)
        
        // 2
        let barcodeAction = UIAlertAction(title: "Scan barcode", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("User chose: Scan barcode")
            self.performSegueWithIdentifier("LibraryToScanner", sender: self)
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

    // http://stackoverflow.com/questions/30729011/swift-2-migration-savecontext-in-appdelegate/30733348#30733348
    func saveContext() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                NSLog("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("viewdidLoad")
        
        // Create default data
        let collectionEntityDescription = NSEntityDescription.entityForName("Collection", inManagedObjectContext: self.managedObjectContext)
        let newCollection = NSManagedObject(entity: collectionEntityDescription!, insertIntoManagedObjectContext: self.managedObjectContext) as? Collection
        
        // Configure
        
        newCollection?.collectionName = "myLibrary"
        newCollection?.bookCollection = Set()

        //print(newCollection?.bookCollection)

        // Save
        do {
            try newCollection!.managedObjectContext?.save()
        } catch {
            print(error)
        }

        self.navigationItem.leftBarButtonItem = self.editButtonItem()


        
        fetchedResultsController = getFetchedResultController()
        //fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch _ {
        }
        

        for book in (myCollection?.bookCollection)! {
            myBooks.append(book)
        }

        tableView.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        print("viewWillAppear")
        
        fetchedResultsController = getFetchedResultController()
        //fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch _ {
        }
        myBooks.removeAll()
        for book in (myCollection?.bookCollection)! {
            myBooks.append(book)
        }
        
        //saveLibrary()
        
        
       // loadLibrary()
        tableView.reloadData()
    }
    
    
    func getFetchedResultController() -> NSFetchedResultsController {
        fetchedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }
    
    func taskFetchRequest() -> NSFetchRequest {
        
        
        
        let context = appDelegate.managedObjectContext
        let fetchRequest1 = NSFetchRequest(entityName: "Collection")
        
        let libraryName = "myLibrary"
        let predicate = NSPredicate(format: "collectionName == %@", libraryName)
        fetchRequest1.predicate = predicate
        let sortDescriptor = NSSortDescriptor(key: "collectionName", ascending: true)
        fetchRequest1.sortDescriptors = [sortDescriptor]
        
        do {
            
            if let fetchResults = try context.executeFetchRequest(fetchRequest1) as? [Collection] {
                if fetchResults.count == 0 {
                    print("Creating new collection: \(libraryName)")
                    let collection = NSEntityDescription.entityForName("Collection", inManagedObjectContext: context)
                    let newCollection = NSManagedObject(entity: collection!, insertIntoManagedObjectContext: context)
                    newCollection.setValue(libraryName, forKey: "collectionName")
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

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //let numberOfSections = fetchedResultsController.sections?.count
        //let numberOfSections = myBooks.count
        //print("Section: \(numberOfSections!)")
        //return numberOfSections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return myLibrary.bookCount
        //let numberOfRowsInSection = fetchedResultsController.sections?[section].numberOfObjects
        //let numberOfRowsInSection = myBooks.count
        //let numberOfRowsInSection = myCollection?.bookCollection?.count
        let numberOfRowsInSection = myBooks.count
        //print("bookCollection count: \(myCollection?.bookCollection?.count)")
        return numberOfRowsInSection
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LibraryBookCell", forIndexPath: indexPath) as! MyLibraryTableViewCell

        // Configure the cell...

        myBooks.removeAll()
        for book in (myCollection?.bookCollection)! {
            myBooks.append(book)
        }

        let current_book = myBooks[indexPath.row]

        
        cell.titleLabel!.text = current_book.title
        
        
        // CELL IMAGES
        if current_book.thumbnail == nil {
            // download image, store in memory
            
            let url : NSURL = NSURL(string: current_book.imageUrl!)!
            
            
            NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
                
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    guard let data = data where error == nil else { return }
                    print(response?.suggestedFilename ?? "")
                    print("Download Finished")
                    let bookImage = UIImage(data: data)
                    current_book.thumbnail = UIImageJPEGRepresentation(bookImage!, 1)
                    //current_book.thumbnail = UIImage(data: data)
                    cell.bookImage.image = bookImage
                    tableView.reloadData()
                }
                
                }.resume()
            
        } else {
            cell.bookImage.image = UIImage(data: current_book.thumbnail!)
        }
        

        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source


            let bookRef : Book = myBooks[indexPath.row]
            print(bookRef)
            let fetchRequest = NSFetchRequest(entityName:"Book")
            let predicate = NSPredicate(format: "title == %@", bookRef.title)
            fetchRequest.predicate = predicate
            
            
            do {
                
                if let fetchResults = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Book] {
                    
                    print(fetchResults.count)
                    print("Removing from Core Data")
                    print(fetchResults[0])
                    managedObjectContext.deleteObject(fetchResults[0] as Book)
                    print("Removing from index")
                    print(myBooks[indexPath.row])
                    myBooks.removeAtIndex(indexPath.row)
                    print("myBooks...")
                    print(myBooks)
                    saveContext()
                    print(myCollection?.bookCollection?.count)
                }
                //print(myCollection?.collectionName)
            } catch {
                print("Error: \(error)")
            }
            
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
    /*
    // MARK: NSCoding
    
    func saveLibrary() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(myLibrary!, toFile: Collection.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save library...")
        }
    }
    
    func loadLibrary() -> Collection? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Collection.ArchiveURL.path!) as? Collection
    }
    */
    // MARK: Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if segue.identifier == "LibraryToScanner" {
            
            if let scannerViewController = segue.destinationViewController as? ScannerViewController {
                //let collection = self.myLibrary
                let collection = self.myCollection
                scannerViewController.myCollection = collection
                
            }

        }
    }
    

}
