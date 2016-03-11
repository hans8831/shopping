//
//  ProductTableViewCell.swift
//  Shopping
//
//  Created by Roland Michelberger on 11/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    var product : Product?
    
    @IBOutlet weak var ProductNameLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func removeOneProductAction(sender: AnyObject) {
    }
    
    @IBAction func addOneProductAction(sender: AnyObject) {
    }

}
