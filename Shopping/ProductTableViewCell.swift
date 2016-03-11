//
//  ProductTableViewCell.swift
//  Shopping
//
//  Created by Roland Michelberger on 11/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!

    var product : Product? {
        didSet {
            productNameLabel.text = product?.name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
