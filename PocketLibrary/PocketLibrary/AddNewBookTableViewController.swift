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
    //var myCollection : Collection?
    
    var myCollection = [NSManagedObject]()
    
    @IBOutlet weak var titleCell: UITableViewCell!
    @IBOutlet weak var authorsCell: UITableViewCell!
    @IBOutlet weak var publisherCell: UITableViewCell!
    @IBOutlet weak var publishDateCell: UITableViewCell!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var publishDatelabel: UILabel!
    @IBOutlet weak var pageCountLabel: UILabel!
    
    @IBAction func saveBook(sender: AnyObject) {
    
        print("You clicked Save")
        //myCollection?.addBook(book!)
    self.performSegueWithIdentifier("unwindToLibrary", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("View loaded")

        if let newBook = book {
            titleLabel!.text = newBook.title
            authorsLabel?.text = newBook.authorStr
            publisherLabel?.text = newBook.publisher
            publishDatelabel?.text = newBook.publishedDateStr
            pageCountLabel?.text = String(newBook.pageCount!)
        }
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "unwindToLibrary" {
            
            if let libraryTableViewController = segue.destinationViewController as? MyLibraryTableViewController {
                let collection = self.myCollection
                libraryTableViewController.myLibrary = collection
            }
            
        }

        
        
    }


}
