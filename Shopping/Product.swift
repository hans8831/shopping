//
//  Product.swift
//  Shopping
//
//  Created by Roland Michelberger on 10/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

class Product {
    
    let id : String
    let name : String
    let unitName : String
    let unitPrice: Price
    let info: String
    
    init(id: String, name: String, unitName: String, unitPrice : Price, info: String) {
        self.id = id
        self.name = name
        self.unitName = unitName
        self.unitPrice = unitPrice
        self.info = info
    }
}

extension Product {
    
    var priceInfo : String {
        get {
            return "\(unitPrice.asString) / \(unitName)"
        }
    }
    
}