//
//  AddNewBookViewController.swift
//  PocketLibrary
//
//  Created by Lucinda Krahl on 4/12/16.
//  Copyright © 2016 Lucinda Krahl. All rights reserved.
//

import UIKit

class AddNewBookViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var publishDateLabel: UILabel!
    
    
    var book : Book!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = book.title
        authorLabel.text = book.authors[0]
        publisherLabel.text = book.publisher!
        publishDateLabel.text = book.publishedDateStr!
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
