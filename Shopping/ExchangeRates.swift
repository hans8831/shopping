//
//  ExchangeRates.swift
//  Shopping
//
//  Created by Roland Michelberger on 11/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

import Foundation

struct ExchangeRates {

    let source: Currency
    let quotes: [ExchangeRate]
    
    init(source: Currency, quotes: [ExchangeRate]) {
        self.source = source
        self.quotes = quotes
    }
    
    init? (dict: [String: AnyObject]) {
        
        // if source not found
        guard let sourceString = dict["source"] as? String else {
            return nil
        }
        
        self.source = Currency(string: sourceString)
        
        // if quotes not found
        guard let quotesDict = dict["quotes"] as? [String: AnyObject] else {
            return nil
        }
        
        var quotes = [ExchangeRate]()
        
        for key in quotesDict.keys {
            
            let currencyString = key.stringByReplacingOccurrencesOfString(source.rawValue, withString: "")
            guard !currencyString.isEmpty else {
                continue
            }
            
            let currency = Currency(string: currencyString)
            if let rate = quotesDict[key]?.doubleValue {
                let exchangeRate = ExchangeRate(from: source, to: currency, rate: rate)
                quotes.append(exchangeRate)
            }
        }
        
        self.quotes = quotes
    }
}
