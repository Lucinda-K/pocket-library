//
//  MyLibraryTableViewCell.swift
//  PocketLibrary
//
//  Created by Lucinda Krahl on 4/19/16.
//  Copyright © 2016 Lucinda Krahl. All rights reserved.
//

import UIKit

class MyLibraryTableViewCell: UITableViewCell {


    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
