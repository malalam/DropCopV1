//
//  copCell.swift
//  DropCopR1
//
//  Created by Mo Alam on 4/19/15.
//  Copyright (c) 2015 Mo Alam. All rights reserved.
//

import UIKit

class copCell: UITableViewCell {
    
    // Add prototype cell elements
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!

    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
