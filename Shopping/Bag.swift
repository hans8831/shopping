//
//  Bag.swift
//  Shopping
//
//  Created by Roland Michelberger on 11/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

import Foundation

struct Bag {
    
    let set = NSCountedSet()
    
    func addProduct(product: Product?) {
        if let product = product {
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
    
    var content : [(procuct: Product, count: Int)]? {
        get {
            var content = [(procuct: Product, count: Int)]()
            
            set.enumerateObjectsUsingBlock({ (product, stop) -> Void in
                content.append((procuct: Product, count: Int)(product as! Product, self.set.countForObject(product)))
            })
            
            return content
        }
    }
    
    var count : Int {
        get {
            return set.count
        }
    }
}
