//
//  Shop.swift
//  Shopping
//
//  Created by Roland Michelberger on 13/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

import Foundation

struct Shop {

    static let products = [Product](arrayLiteral:
        Product(id: "_id_peas", name: "peas", unit: Unit(string: "bag"), unitPrice: Price(amount: NSDecimalNumber(double: 0.95), currency: .USD), info: "This is the peas info text"),
        Product(id: "_id_eggs", name: "eggs", unit: Unit(string: "dozen"), unitPrice: Price(amount: NSDecimalNumber(double: 2.1), currency: .USD), info: "This is the eggs info text"),
        Product(id: "_id_milk", name: "milk", unit: Unit(string: "bottle"), unitPrice: Price(amount: NSDecimalNumber(double: 1.3), currency: .USD), info: "This is the milk info text"),
        Product(id: "_id_beans", name: "beans", unit: Unit(string: "can"), unitPrice: Price(amount: NSDecimalNumber(double: 0.73), currency: .USD), info: "This is the beans info text")
    )
    
}
