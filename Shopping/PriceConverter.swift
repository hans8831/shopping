//
//  PriceConverter.swift
//  Shopping
//
//  Created by Roland Michelberger on 10/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

import Foundation

class PriceConverter {
    
    static let ERROR_DOMAIN = "roland.michelberger.shopping.PriceConverter"
    
    static let NO_RESPONSE_DATA_RECEIVED = -1
    static let NO_RATE_RECEIVED = -2
    
    class func pricesForPrice(price: Price, completion: (prices: [Price]?, error: NSError?) -> Void) {
        // get exchange rates
        exChangeRates(price.currency) { (exchangeRates, error) -> Void in
            if let _ = error {
                completion(prices: nil, error: error)
            } else if let exchangeRates = exchangeRates {
                var prices = [Price]()
                
                for exchangeRate in exchangeRates.quotes {
                    if let price = convertPrice(price, exchangeRate: exchangeRate) {
                        prices.append(price)
                    }
                }
                
                completion(prices: prices, error: nil)
                
            } else {
                completion(prices: nil, error: NSError(domain: ERROR_DOMAIN, code: NO_RATE_RECEIVED, userInfo: [NSLocalizedDescriptionKey : "No exchange rates received."]))
            }
        }
    }
    
    class func convertPrice(price: Price, exchangeRate: ExchangeRate) -> Price? {
        // make sure, that the exchange rate currency is the same as for the price to be converted
        guard price.currency == exchangeRate.from else {
            return nil
        }
        return Price(amount: price.amount.decimalNumberByMultiplyingBy(NSDecimalNumber(double: exchangeRate.rate)), currency: exchangeRate.to)
    }
    
    class func exChangeRates(currency: Currency, completion: (exchangeRates: ExchangeRates?, error: NSError?) -> Void) {
        #if MOCK
            MockExchangeRatesServer.exchangeRatesData(currency) { (data, error) -> Void in
                if let _ = error {
                    completion(exchangeRates:nil, error: error)
                } else if let data = data {
                    let result = JSONParser.exchangeRatesFromJSONRateResponseData(data)
                    
                    if let _ = result.error {
                        completion(exchangeRates: nil, error: result.error)
                    } else if let _ = result.exchangeRates {
                        completion(exchangeRates: result.exchangeRates, error: nil)
                    } else {
                        completion(exchangeRates: nil, error: NSError(domain: ERROR_DOMAIN, code: NO_RATE_RECEIVED, userInfo: [NSLocalizedDescriptionKey : "No exchange rates received."]))
                    }
                } else {
                    completion(exchangeRates: nil, error: NSError(domain: ERROR_DOMAIN, code: NO_RESPONSE_DATA_RECEIVED, userInfo: [NSLocalizedDescriptionKey : "No response data received."]))
                }
            }
        #else
            ExchangeRatesServer.exchangeRatesData(currency) { (data, error) -> Void in
                if let _ = error {
                    completion(exchangeRates:nil, error: error)
                } else if let data = data {
                    let result = JSONParser.exchangeRatesFromJSONRateResponseData(data)
                    
                    if let _ = result.error {
                        completion(exchangeRates: nil, error: result.error)
                    } else if let _ = result.exchangeRates {
                        completion(exchangeRates: result.exchangeRates, error: nil)
                    } else {
                        completion(exchangeRates: nil, error: NSError(domain: ERROR_DOMAIN, code: NO_RATE_RECEIVED, userInfo: [NSLocalizedDescriptionKey : "No exchange rates received."]))
                    }
                } else {
                    completion(exchangeRates: nil, error: NSError(domain: ERROR_DOMAIN, code: NO_RESPONSE_DATA_RECEIVED, userInfo: [NSLocalizedDescriptionKey : "No response data received."]))
                }
            }
        #endif
    }
    
}
