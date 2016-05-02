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

    
    //var myLibrary = Collection(name: "myLibrary", books: [], bookCount: 0)
    
    //var myLibrary = [NSManagedObject]()   // Core Data - [Book]

    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    //var myLibrary : [Book] = []
    
    var myCollection : Collection?
    var myLibrary = [Book]()
    
    //var book1 = Book(title: "Harry Potter and the Prisoner of Azkaban", authors: ["J.K. Rowling"])
    //var book2 = Book(title: "Story of a Soul", authors: ["Therese of Lisieux"])
    
    // Unwind segue from cancel button
    @IBAction func cancelToLibraryViewController(segue: UIStoryboardSegue) {}
    
    @IBAction func unwindToLibraryViewControll(segue: UIStoryboardSegue) { }
    
    var fetchedResultsController: NSFetchedResultsController = NSFetchedResultsController()
    
    
    func fetchData() {
        print("Fetching data")
        let context = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Collection")
        
        let libraryName = "myLibrary"
        let predicate = NSPredicate(format: "collectionName == %@", libraryName)
        fetchRequest.predicate = predicate
        
        do {
            
            if let fetchResults = try context.executeFetchRequest(fetchRequest) as? [Collection] {
                print("retchResults.count: \(fetchResults.count)")
                if fetchResults.count == 0 {
                        let collection = NSEntityDescription.entityForName("Collection", inManagedObjectContext: context)
                        let newCollection = NSManagedObject(entity: collection!, insertIntoManagedObjectContext: context)
                        newCollection.setValue(libraryName, forKey: "collectionName")
                }
                else {
                    myCollection = fetchResults[0]
                }

            }
        } catch {
            print("Error: \(error)")
        }

            /*
        do {
            //myLibrary = try context.executeFetchRequest(fetchRequest) as! [Book]
            myLibrary = try context.executeFetchRequest(fetchRequest) as! [Book]
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
        } catch {
            print("Error: \(error)")
        }
        */
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        print("View loaded")
        
        super.viewDidLoad()
        fetchedResultsController = getFetchedResultController()
        //fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch _ {
        }
        
        
        //myLibrary!.addBook(book1!)
        //myLibrary!.addBook(book2!)
        /*
        for book in myLibrary.books {
            print("Printing book...")
            print(book.title)
        }
        */
        /*
        for book in myLibrary{
            print("Printing book...")
            print(book.valueForKey("title"))
        }
        */
        
        
        
        
        
        //saveLibrary()
        //loadLibrary()
        tableView.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        
        
        
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
                    let collection = NSEntityDescription.entityForName("Collection", inManagedObjectContext: context)
                    let newCollection = NSManagedObject(entity: collection!, insertIntoManagedObjectContext: context)
                    newCollection.setValue(libraryName, forKey: "collectionName")
                    myCollection = newCollection as? Collection
                }
                else {
                    myCollection = fetchResults[0]
                }
                print(myCollection)
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
        let numberOfSections = fetchedResultsController.sections?.count
        print("Section: \(numberOfSections!)")
        return numberOfSections!
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return myLibrary.bookCount
        let numberOfRowsInSection = fetchedResultsController.sections?[section].numberOfObjects
        return numberOfRowsInSection!
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LibraryBookCell", forIndexPath: indexPath) as! MyLibraryTableViewCell

        // Configure the cell...
        //var book : Book
        
        //let book = myLibrary[indexPath.row]
        
        //var myBooks = [NSManagedObject]()
        //myBooks = (myCollection?.bookCollection)! as [Book]
        
        //myBooks = (myCollection?.bookCollection)!
        
        //let book = myBooks[indexPath.row]
        
        let collection = fetchedResultsController.objectAtIndexPath(indexPath) as! Collection
        //let bookCollection = collection.bookCollection as [Book]
        
        
        //cell.titleLabel!.text = book.title
        
        
        //var myBooks = myCollection?.mutableSetValueForKey("books")
        
        //let book = myBooks[indexPath.row]
        
        
        //book = myLibrary!.books[indexPath.row]
        //cell.titleLabel!.text = book.valueForKey("title") as? String
        
        //cell.titleLabel!.text = book.title
        //cell.authorLabel!.text = book.authorStr
        
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
