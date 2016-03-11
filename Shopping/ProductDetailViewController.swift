//
//  ProductDetailViewController.swift
//  Shopping
//
//  Created by Roland Michelberger on 11/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var unitPriceInfoLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!

    var product: Product?
    var bag: ProductBag?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = product?.name
        
        unitPriceInfoLabel.text = product?.priceInfo
        updateAmountLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateAmountLabel() {
        if let bag = bag {
            amountLabel.text = "\(bag.countForProduct(product))"
        } else {
            amountLabel.text = "0"
        }
    }

    @IBAction func increaseCounter() {
        bag?.addProduct(product)
        updateAmountLabel()
    }

    @IBAction func decreaseCounter() {
        bag?.removeProduct(product)
        updateAmountLabel()
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
