//
//  ProductBag.swift
//  Shopping
//
//  Created by Roland Michelberger on 11/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

import Foundation

struct ProductBag {
    
    let currency: Currency
    
    init (currency: Currency) {
        self.currency = currency
    }
    
    let set = NSCountedSet()
    
    // only product with same price currency can be added
    func addProduct(product: Product?) {
        if let product = product where product.unitPrice.currency == currency {
            set.addObject(product)
        }
    }
    
    func removeProduct(product: Product?) {
        if let product = product {
            set.removeObject(product)
        }
    }
    
    func countForProduct(product : Product?) -> Int {
        if let product = product {
            return set.countForObject(product)
        }
        return 0
    }
    
    var content: [(procuct: Product, count: Int)]? {
        get {
            var content = [(procuct: Product, count: Int)]()
            
            set.enumerateObjectsUsingBlock({ (product, stop) -> Void in
                content.append((procuct: Product, count: Int)(product as! Product, self.set.countForObject(product)))
            })
            
            return content
        }
    }
    
    var totalPrice: Price {
        get {
            var totalAmount = NSDecimalNumber(double: 0)
            if let content = content {
                for item in content {
                    let itemAmount = item.procuct.unitPrice.amount.decimalNumberByMultiplyingBy(NSDecimalNumber(int: Int32(item.count)))
                    totalAmount = totalAmount.decimalNumberByAdding(itemAmount)
                }
            }
            return Price(amount: totalAmount, currency: currency)
        }
    }
    
    var count : Int {
        get {
            return set.count
        }
    }
}
