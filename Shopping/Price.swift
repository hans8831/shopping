//
//  Price.swift
//  Shopping
//
//  Created by Roland Michelberger on 10/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

import Foundation

struct Price {
    
    let amount : NSDecimalNumber
    let currency : Currency
    
    init (amount: NSDecimalNumber, currencyString : String) {
        self.amount = amount
        self.currency = Currency(string: currencyString)
    }
    
    init (amount: NSDecimalNumber, currency : Currency) {
        self.amount = amount
        self.currency = currency
    }
}

extension Price {
    
    var asString : String {
        get {
            return "\(currency.rawValue) \(amount)"
        }
    }
}
