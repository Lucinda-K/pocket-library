//
//  ScannerViewController.swift
//  PocketLibrary
//
//  Created by Lucinda Krahl on 4/4/16.
//  Copyright © 2016 Lucinda Krahl. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    // http://pastebin.com/gDgLRXuQ
    
    @IBOutlet weak var cameraView: UIImageView!
    
    @IBOutlet weak var dataLabel: UILabel!
    
    @IBOutlet weak var dataTypeLabel: UILabel!
    
    @IBAction func cancelToScannerViewController(segue: UIStoryboardSegue) { }
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    //MARK: Properties
    /// Runs the capture session.
    let captureSession = AVCaptureSession()
    /// The device used as input for the capture session.
    var captureDevice:AVCaptureDevice?
    /// The UI layer to display the feed from the input source, in our case, the camera.
    var captureLayer:AVCaptureVideoPreviewLayer?
    //var bookToAdd : Book?
    var newBook : Book?
    //var bookToAdd = NSManagedObject()
    var json_books: [JSON] = []
    let api_key = valueForAPIKey(keyname: "API_KEY")

    var newBooks = [Book]()
    
    //var collection : [Book] = []
    
    //var collection = [NSManagedObject]()
    var collection : Collection?
    
    var googlebooks: GoogleBooksService?

    // These won't be needed once a Book object exists
    var title1 : String = ""
    var publisher : String = ""
    var authors : [String] = []
    var pageCount : Int = 0
    
    // These won't be needed once a view controller for displaying data exists
    var dataValue = ""
    var dataType = ""

    // For passing the collection
    //var myCollection : Collection?
    
    //var myCollection = [NSManagedObject]()
    
    var myCollection : Collection?
    
    
    func cancel(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
        navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        print("view loaded: ScannerViewController")
        print(myCollection)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.googlebooks = GoogleBooksService(API_KEY: api_key)
        self.setupCaptureSession()

    }
    
    private func setupCaptureSession(){
        self.captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        let deviceInput:AVCaptureDeviceInput
        do {
            deviceInput = try AVCaptureDeviceInput(device: captureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(deviceInput)){
            // Show live feed
            captureSession.addInput(deviceInput)
            self.setupPreviewLayer({
                self.captureSession.startRunning()
                self.addMetaDataCaptureOutToSession()
            })
        } else {
            self.showError("Error while setting up input captureSession.")
        }
    }
    
    /**
     Handles setting up the UI to show the camera feed.
     
     - parameter completion: Completion handler to invoke if setting up the feed was successful.
     */
    private func setupPreviewLayer(completion:() -> ())
    {
        self.captureLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        if let capLayer = self.captureLayer {
            capLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            capLayer.frame = self.cameraView.frame
            self.view.layer.addSublayer(capLayer)
            completion()
        } else {
            self.showError("An error occured beginning video capture")
        }
    }
    
    //MARK: Metadata capture
    /**
    Handles identifying what kind of data output we want from the session, in our case, metadata and the available types of metadata.
    */
    private func addMetaDataCaptureOutToSession()
    {
        let metadata = AVCaptureMetadataOutput()
        self.captureSession.addOutput(metadata)
        metadata.metadataObjectTypes = metadata.availableMetadataObjectTypes
        metadata.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
    }
    
    //MARK: Delegate Methods
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!)
    {
        print("Capturing metadata...")
        if (self.dataValue == "") {
            for metadata in metadataObjects{
                print("Decoding metadata...")
                let decodedData:AVMetadataMachineReadableCodeObject = metadata as! AVMetadataMachineReadableCodeObject
                self.dataLabel.text = decodedData.stringValue
                self.dataValue = decodedData.stringValue
                self.dataType = decodedData.type
                
                self.googlebooks!.queryByISBN(decodedData.stringValue) {
                    (books) in
                        self.json_books = books
                        for json_book in books {
                            
                            //let book = Book(data: book)
                            
                            let book = NSEntityDescription.insertNewObjectForEntityForName("Book", inManagedObjectContext: self.appDelegate.managedObjectContext) as! Book
                            
                            book.title = String(json_book["volumeInfo"]["title"])
                            book.subtitle = String(json_book["volumeInfo"]["subtitle"])
                            print("JSON BOOK INFO")
                            print(book)
                            //self.collection.append(book!)
                            self.newBooks.append(book)
                            
                            /*
                            self.books.append(book)
                            let result_book = book
                            self.title1 = String(result_book["volumeInfo"]["title"])
                            self.publisher = String(result_book["volumeInfo"]["publisher"])
                            self.pageCount = Int(String(result_book["volumeInfo"]["pageCount"]))!
                            for author in result_book["volumeInfo"]["authors"] {
                                self.authors.append(String(author))
                            }
                            */
                            //self.dataTypeLabel.text = self.title1
                            /*
                            print("Title: \(self.title1)")
                            print("Publisher: \(self.publisher)")
                            print("Pages: \(self.pageCount)")
                            print("Authors: \(self.authors.count)")
                            print(self.authors[0])
                            for author in self.authors {
                                print(author)
                            }
                            */
                            
                        }
                    print("Queried")
                }
                //print(self.dataValue)
            }
        }
        var count = 0
        //for book in self.collection {
        for book in self.newBooks {
            print("Book found")
            count+=1
            print("Book: \(count)")
            print("Title: \(book.title)")
            //print("Title: \(book.valueForKey("title"))")
            //print("Publisher: \(String(book.publisher!))")
            //print("Publish date: \(String(book.publishedDateStr!))")
            //print("Pages: \(book.pageCount)")
            //self.bookToAdd = book
            self.newBook = book
        }
        //print("End of captureOutput function")
        if count > 0 {
            print("Ending capture session")
            self.captureSession.stopRunning()
            performSegueWithIdentifier("ScannerToNewBook", sender: self)
        }
        //dispatch_async(dispatch_get_main_queue(), { () -> Void in
            //self.performSegueWithIdentifier("addBarcodeItem", sender: self)
        //})
    }
    
    //MARK: Utility Functions
    /**
    Shows any error that may occur via an alert view.
    
    - parameter error: The error message.
    */
    private func showError(error:String)
    {
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .Alert)
        let dismiss:UIAlertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Destructive, handler:{(alert:UIAlertAction) in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        })
        alertController.addAction(dismiss)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    
    // MARK: - Navigation
    

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ScannerToNewBook" {
            
            if let addNewBookTableViewController = segue.destinationViewController as? AddNewBookTableViewController {
                //let book = self.bookToAdd
                //addNewBookTableViewController.book = book
                let book = self.newBook
                addNewBookTableViewController.book = book
                let collection = self.myCollection
                addNewBookTableViewController.myCollection = collection
                print("SEGUE: Scanner-->NewBook")
                print("Passing: \(book!.title)")
                print("Passing Collection \(collection!.collectionName)")
            }
            
        }
    }

}

