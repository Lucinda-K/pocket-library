//
//  MyLibraryTableViewController.swift
//  PocketLibrary
//
//  Created by Lucinda Krahl on 4/18/16.
//  Copyright © 2016 Lucinda Krahl. All rights reserved.
//

import UIKit
import CoreData

class MyLibraryTableViewController: UITableViewController {

    
    //var myLibrary = Collection(name: "myLibrary", books: [], bookCount: 0)
    
    //var myLibrary = [NSManagedObject]()   // Core Data - [Book]

    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    //var myLibrary : [Book] = []
    
    var myCollection = Collection()
    var myLibrary = [Book]()
    
    //var book1 = Book(title: "Harry Potter and the Prisoner of Azkaban", authors: ["J.K. Rowling"])
    //var book2 = Book(title: "Story of a Soul", authors: ["Therese of Lisieux"])
    
    // Unwind segue from cancel button
    @IBAction func cancelToLibraryViewController(segue: UIStoryboardSegue) {}
    
    @IBAction func unwindToLibraryViewControll(segue: UIStoryboardSegue) { }
    
    func fetchData() {
        let context = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Collection")
        
        do {
            //myLibrary = try context.executeFetchRequest(fetchRequest) as! [Book]
            myLibrary = try context.executeFetchRequest(fetchRequest) as! [Book]
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
        } catch {
            print("Error: \(error)")
        }
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        print("View loaded")
        
        let context = appDelegate.managedObjectContext
        
        myLibrary = myCollection.bookCollection as! [Book]
        myCollection.setValue("libraryCollection", forKey: "name")
        
        self.fetchData()
        
        //myLibrary!.addBook(book1!)
        //myLibrary!.addBook(book2!)
        /*
        for book in myLibrary.books {
            print("Printing book...")
            print(book.title)
        }
        */
        for book in myLibrary{
            print("Printing book...")
            print(book.valueForKey("title"))
        }
        
        
        
        
        
        
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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return myLibrary.bookCount
        return myLibrary.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LibraryBookCell", forIndexPath: indexPath) as! MyLibraryTableViewCell

        // Configure the cell...
        //var book : Book
        
        let book = myLibrary[indexPath.row]
        
        //book = myLibrary!.books[indexPath.row]

        cell.titleLabel!.text = book.valueForKey("title") as? String
        
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
