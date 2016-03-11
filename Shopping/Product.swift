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
    let price: Price
    
    init(name: String, unitName: String, price : Price) {
        self.name = name
        self.unitName = unitName
        self.price = price
    }
    
}
