//
//  PriceConverter.swift
//  Shopping
//
//  Created by Roland Michelberger on 10/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

import Foundation

class PriceConverter {
    
    static let ERROR_DOMAIN = "ch.miro.shopping.PriceConverter"
    
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
        // make sure, that the exchange rate is for the price to be converted
        guard price.currency == exchangeRate.from else {
            return nil
        }
        return Price(amount: price.amount.decimalNumberByMultiplyingBy(NSDecimalNumber(double: exchangeRate.rate)), currency: exchangeRate.to)
    }
    
    class func exChangeRates(currency: Currency, completion: (exchangeRates: ExchangeRates?, error: NSError?) -> Void) {
        #if MOCK
            MockServer.exchangeRatesData(currency) { (data, error) -> Void in
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
            Server.exchangeRatesData(currency) { (data, error) -> Void in
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
    
    
    /**
     * Converts a price to another currency
     * @param price: price to be converted
     * @param toCurrency: currency to convert
     * @param completion: block called with the converted price or error
     */
    class func convertPrice(price: Price, toCurrency: Currency, completion: (price: Price?, error: NSError?) -> Void) {
        // if the two currencies are the same
        // return the original price
        if (toCurrency == price.currency) {
            completion(price: price, error: nil)
        }
            // get conversion rate
        else {
            exchangeRate(price.currency, to: toCurrency, completion: { (exchangeRate, error) -> Void in
                if let _ = error {
                    completion(price: nil, error: error)
                } else if let exchangeRate = exchangeRate {
                    let amount = price.amount.decimalNumberByMultiplyingBy(NSDecimalNumber(double: exchangeRate.rate))
                    let convertedPrice = Price(amount: amount, currency: toCurrency)
                    completion(price: convertedPrice, error: nil)
                }
            })
        }
    }
    
    /**
     * Gets exchange rate
     * @param from: currency to convert from
     * @param to: currency to convert to
     * @param completion: block called with the exchange rate or error
     */
    class func exchangeRate(from: Currency, to: Currency, completion: (exchangeRate: ExchangeRate?, error: NSError?) -> Void) {
        // if the two currencies are the same
        // return 1
        if (to == from) {
            completion(exchangeRate: ExchangeRate(from: from, to: to, rate: 1), error: nil)
        }
            // get conversion rate
        else {
            #if MOCK
                MockServer.exchangeRateData(from, to: to, completion: { (data, error) -> Void in
                    if let _ = error {
                        completion(exchangeRate: nil, error: error)
                    } else if let data = data {
                        let result = JSONParser.exchangeRateFromJSONRateResponseData(data)
                        
                        if let _ = result.error {
                            completion(exchangeRate: nil, error: result.error)
                        } else if let exchangeRate = result.exchangeRate {
                            completion(exchangeRate: exchangeRate, error: nil)
                        } else {
                            completion(exchangeRate: nil, error: NSError(domain: ERROR_DOMAIN, code: NO_RATE_RECEIVED, userInfo: [NSLocalizedDescriptionKey : "No exchange rate received."]))
                        }
                    } else {
                        completion(exchangeRate: nil, error: NSError(domain: ERROR_DOMAIN, code: NO_RESPONSE_DATA_RECEIVED, userInfo: [NSLocalizedDescriptionKey : "No response data received."]))
                    }
                    
                })
            #else
                Server.exchangeRateData(from, to: to, completion: { (data, error) -> Void in
                    if let _ = error {
                        completion(exchangeRate: nil, error: error)
                    } else if let data = data {
                        let result = JSONParser.exchangeRateFromJSONRateResponseData(data)
                        
                        if let _ = result.error {
                            completion(exchangeRate: nil, error: result.error)
                        } else if let exchangeRate = result.exchangeRate {
                            completion(exchangeRate: exchangeRate, error: nil)
                        } else {
                            completion(exchangeRate: nil, error: NSError(domain: ERROR_DOMAIN, code: NO_RATE_RECEIVED, userInfo: [NSLocalizedDescriptionKey : "No exchange rate received."]))
                        }
                    } else {
                        completion(exchangeRate: nil, error: NSError(domain: ERROR_DOMAIN, code: NO_RESPONSE_DATA_RECEIVED, userInfo: [NSLocalizedDescriptionKey : "No response data received."]))
                    }
                    
                })
            #endif
        }
    }
}
