//
//  ExchangeRatesServer.swift
//  Shopping
//
//  Created by Roland Michelberger on 13/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

import Foundation

class ExchangeRatesServer: Server {
    
    /**
     * Get rates from currency layers
     * source is USD
     * @return NSURLSessionDataTask, to be able to cancel the network call
     */
    class func exchangeRatesDataForUSD(completion: (data: NSData?, error: NSError?) -> Void) -> NSURLSessionDataTask? {
        return exchangeRatesData(.USD, completion: completion)
    }
    
    /**
     * Get rates from currency layers
     * @param source: source currency
     * @return NSURLSessionDataTask, to be able to cancel the network call
     */
    class func exchangeRatesData(sourceCurrency: Currency, completion: (data: NSData?, error: NSError?) -> Void) -> NSURLSessionDataTask? {
        let urlString = "\(Constants.CURRENCY_LAYER_BASE_URL)/api/live?access_key=\(Constants.CURRENCY_LAYER_API_KEY)&source=\(sourceCurrency.rawValue)"
        return data(urlString, completion: completion)
    }

}
