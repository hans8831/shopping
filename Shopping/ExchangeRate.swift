//
//  ExchangeRate.swift
//  Shopping
//
//  Created by Roland Michelberger on 10/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

struct ExchangeRate {

    let from: Currency
    let to: Currency
    let rate: Double
    
    init(from: Currency, to: Currency, rate: Double) {
        self.from = from
        self.to = to
        self.rate = rate
    }

}
