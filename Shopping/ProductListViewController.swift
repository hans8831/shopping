//
//  ProductListViewController.swift
//  Shopping
//
//  Created by Roland Michelberger on 11/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let bag = ProductBag(currency: .USD)
    
    let products = Shop.products
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()        
        navigationItem.rightBarButtonItem?.enabled = bag.count > 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let productDetailViewController = segue.destinationViewController as? ProductDetailViewController {
            productDetailViewController.bag = bag
            if let indexPath = tableView.indexPathForSelectedRow {
                productDetailViewController.product = products[indexPath.row]
            }
        } else if let basketViewController = segue.destinationViewController as? BasketViewController {
            basketViewController.bag = bag
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let product = products[indexPath.row]
        
        cell.textLabel?.text = "\(product.name): \(bag.countForProduct(product))"
        cell.detailTextLabel?.text = "\(product.priceInfo)"
        
        return cell        
    }
    
}
