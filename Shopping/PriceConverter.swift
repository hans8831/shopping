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
    
    /**
     * Get prices in different currencies for a price
     * @param price: the original prices
     * @param completion: the prices with the converted amount based on the exchange rates
     */
    class func pricesForPrice(price: Price, completion: (prices: [Price]?, error: NSError?) -> Void) {
        // get exchange rates
        #if MOCK
            mockExchangeRates(price.currency) { (exchangeRates, error) -> Void in
                if let _ = error {
                    completion(prices: nil, error: error)
                } else if let exchangeRates = exchangeRates {
                    let prices = pricesForPrice(price, withExchangeRates: exchangeRates)
                    completion(prices: prices, error: nil)
                } else {
                    completion(prices: nil, error: NSError(domain: ERROR_DOMAIN, code: NO_RATE_RECEIVED, userInfo: [NSLocalizedDescriptionKey : "No exchange rates received."]))
                }
            }
        #else
            exchangeRates(price.currency) { (exchangeRates, error) -> Void in
                if let _ = error {
                    completion(prices: nil, error: error)
                } else if let exchangeRates = exchangeRates {
                    let prices = pricesForPrice(price, withExchangeRates: exchangeRates)
                    completion(prices: prices, error: nil)
                } else {
                    completion(prices: nil, error: NSError(domain: ERROR_DOMAIN, code: NO_RATE_RECEIVED, userInfo: [NSLocalizedDescriptionKey : "No exchange rates received."]))
                }
            }
        #endif
    }
    
    class func pricesForPrice(price: Price, withExchangeRates exchangeRates: ExchangeRates) -> [Price] {
        var prices = [Price]()
        
        for exchangeRate in exchangeRates.quotes {
            if let price = convertPrice(price, exchangeRate: exchangeRate) {
                prices.append(price)
            }
        }
        return prices
    }

    /**
     * Convert price with exchange rat
     * @param price: price to be converterd
     * @param exchangeRate: the exchange rate to use for converting
     */
    class func convertPrice(price: Price, exchangeRate: ExchangeRate) -> Price? {
        // make sure, that the exchange rate currency is the same as for the price to be converted
        guard price.currency == exchangeRate.from else {
            return nil
        }
        return Price(amount: price.amount.decimalNumberByMultiplyingBy(NSDecimalNumber(double: exchangeRate.rate)), currency: exchangeRate.to)
    }
    
    /**
     * Get exhcange rates for currency
     * @param currency: the source currency
     * @param completion: the completion block with the exchange rates or error
     */
    class func exchangeRates(currency: Currency, completion: (exchangeRates: ExchangeRates?, error: NSError?) -> Void) {
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
    }
    
    // MARK: - Mock
    
    class func mockExchangeRates(currency: Currency, completion: (exchangeRates: ExchangeRates?, error: NSError?) -> Void) {
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
    }
}
