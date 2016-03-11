//
//  ExchangeRate.swift
//  Shopping
//
//  Created by Roland Michelberger on 10/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

import Foundation

struct ExchangeRate {
    
    let from: Currency
    let to: Currency
    let rate: Double
    
    init(from: Currency, to: Currency, rate: Double) {
        self.from = from
        self.to = to
        self.rate = rate
    }
    
    init?(dict: [String: AnyObject]) {
        let mirror = Mirror(reflecting: dict["rate"]!)
        print("rate: \(mirror.subjectType)")
        if let from = dict["from"] as? String,
            let to = dict["to"] as? String,
            let rate = dict["rate"] as? NSString {
                self.from = Currency(string: from)
                self.to = Currency(string: to)
                self.rate = rate.doubleValue
        }  else {
            return nil
        }
    }
    
}
