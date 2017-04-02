//
//  AddNewBookTableViewController.swift
//  PocketLibrary
//
//  Created by Lucinda Krahl on 4/13/16.
//  Copyright © 2016 Lucinda Krahl. All rights reserved.
//

import UIKit
import CoreData

class AddNewBookTableViewController: UITableViewController {

    var book : Book?

    //var myCollection : [Book] = []
    var myCollection : Collection?
    
    @IBOutlet weak var titleCell: UITableViewCell!
    @IBOutlet weak var authorsCell: UITableViewCell!
    @IBOutlet weak var publisherCell: UITableViewCell!
    @IBOutlet weak var publishDateCell: UITableViewCell!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var publishDatelabel: UILabel!
    @IBOutlet weak var pageCountLabel: UILabel!
    
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    @IBAction func saveBook(_ sender: AnyObject) {
    
        print("You clicked Save")
        print("Saving to: \(myCollection?.collectionName!)")
        
        myCollection?.bookCollection?.insert(book!)
        
        do {
            try myCollection?.managedObjectContext?.save()
        } catch {
            print(error)
        }
        
        /*
        let collectionEntityDescription = NSEntityDescription.entityForName("Collection", inManagedObjectContext: self.managedObjectContext)
        let newCollection = NSManagedObject(entity: collectionEntityDescription!, insertIntoManagedObjectContext: self.managedObjectContext) as? Collection
        
        
        let bookEntityDescription = NSEntityDescription.entityForName("Book", inManagedObjectContext: self.managedObjectContext)
        let newBook = NSManagedObject(entity: bookEntityDescription!, insertIntoManagedObjectContext: self.managedObjectContext) as? Book*/
        //myCollection?.addBook(book!)
        
        if myCollection?.collectionName == "myReading" {
            //self.performSegueWithIdentifier("unwindToReading", sender: self)
            self.performSegue(withIdentifier: "NewBookToReading", sender: self)
        }else if myCollection?.collectionName == "myLibrary" {
            //self.performSegueWithIdentifier("unwindToLibrary", sender: self)
            self.performSegue(withIdentifier: "NewBookToLibrary", sender: self)
        } else if myCollection?.collectionName == "myWishList" {
            //self.performSegueWithIdentifier("unwindToWishList", sender: self)
            self.performSegue(withIdentifier: "NewBookToWishList", sender: self)
        } else {
            //self.performSegueWithIdentifier("unwindToLibrary", sender: self)
            self.performSegue(withIdentifier: "NewBookToLibrary", sender: self)
        }
        
        //self.performSegueWithIdentifier("unwindToLibrary", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("View loaded")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(AddNewBookTableViewController.saveBook(_:)))
        
        if let newBook = book {
            titleLabel!.text = newBook.title
            authorsLabel?.text = newBook.authorStr
            //publisherLabel?.text = newBook.publisher
            //publishDatelabel?.text = newBook.publishedDateStr
            pageCountLabel?.text = String(describing: newBook.pageCount!)
        }
        
        print("Current collection")
        print(myCollection!)
        
        //authorsLabel?.text = book!.authorStr
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //if segue.identifier == "unwindToLibrary" {
        if segue.identifier == "NewBookToLibrary" {
            
            if let libraryTableViewController = segue.destination as? MyLibraryTableViewController {
                let collection = self.myCollection
                libraryTableViewController.myCollection = collection
            }
            
        }
        //if segue.identifier == "unwindToReading" {
        if segue.identifier == "NewBookToReading" {
            
            if let readingTableViewController = segue.destination as? MyReadingTableViewController {
                let collection = self.myCollection
                readingTableViewController.myCollection = collection
            }
            
        }
        //if segue.identifier == "unwindToWishList" {
        if segue.identifier == "NewBookToWishList" {
            if let wishListTableViewController = segue.destination as? MyWishListTableViewController {
                let collection = self.myCollection
                //wishListTableViewController.myCollection = collection
            }
            
        }


        
        
    }


}
