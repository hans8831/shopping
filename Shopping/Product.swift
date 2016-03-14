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
    let unit : Unit
    let unitPrice: Price
    let info: String
    
    init(id: String, name: String, unit: Unit, unitPrice : Price, info: String) {
        self.id = id
        self.name = name
        self.unit = unit
        self.unitPrice = unitPrice
        self.info = info
    }
}

extension Product {
    
    var priceInfo : String {
        get {
            return "\(unitPrice.asString) / \(unit.rawValue)"
        }
    }
    
}