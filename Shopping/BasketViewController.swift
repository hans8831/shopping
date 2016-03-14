//
//  BasketViewController.swift
//  Shopping
//
//  Created by Roland Michelberger on 11/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

import UIKit

class BasketViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var bag: ProductBag?
    var prices = [Price]()
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Basket"
        
        if let bag = bag {
            totalAmountLabel.text = "total: \(bag.totalPrice.asString)"
        } else {
            totalAmountLabel.text = "-"
        }
        
        refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
        
        // animate refresh control
        
        refreshControl.beginRefreshing()        
        refresh()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh() {
        if let bag = bag {
            let totalPrice = bag.totalPrice
            PriceConverter.pricesForPrice(totalPrice, completion: { (prices, error) -> Void in
                if let _ = error {
                    self.clearPrices()
                } else if let prices = prices {
                    // sort currency alphabetic
                    self.prices = prices.sort({ $0.currency.rawValue < $1.currency.rawValue })
                    self.refreshControl.endRefreshing()
                    self.tableView.reloadData()
                }
            })
        } else {
            clearPrices()
        }
    }
    
    func clearPrices() {
        prices.removeAll()
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prices.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let price = prices[indexPath.row]
        // TODO: add proper number formatting
        cell.textLabel?.text = "\(price.amount)"
        cell.detailTextLabel?.text = price.currency.rawValue
        
        return cell
        
    }
    
}
