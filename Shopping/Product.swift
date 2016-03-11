//
//  Product.swift
//  Shopping
//
//  Created by Roland Michelberger on 10/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

struct Product {
    
    let name : String
    let unitName : String
    let unitPrice: Price
    
    init(name: String, unitName: String, unitPrice : Price) {
        self.name = name
        self.unitName = unitName
        self.unitPrice = unitPrice
    }
    
}
