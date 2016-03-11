//
//  Server.swift
//  Shopping
//
//  Created by Roland Michelberger on 10/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

import Foundation

class Server {
    
    static let ERROR_DOMAIN = "ch.miro.shopping.Server"
    
    static let WRONG_URL_FORMAT_ERROR_CODE = -1

    /**
     * Get rates from currency layers
     * source is USD
     * @return NSURLSessionDataTask, to be able to cancel the network call
     */
    class func exchangeRatesDataForUSD(completion: (data: NSData?, error: NSError?) -> Void) -> NSURLSessionDataTask? {
        let urlString = "http://apilayer.net/api/live?access_key=\(Constants.JSON_RATES_API_KEY)&source=USD"
        return data(urlString, completion: completion)
    }
    
    /**
     * Get rates from currency layers
     * @param source: source currency
     * @return NSURLSessionDataTask, to be able to cancel the network call
     */
    class func exchangeRatesData(source: Currency, completion: (data: NSData?, error: NSError?) -> Void) -> NSURLSessionDataTask? {
        let urlString = "http://apilayer.net/api/live?access_key=\(Constants.JSON_RATES_API_KEY)&source=\(source.rawValue)"
        return data(urlString, completion: completion)
    }

    
    /**
     * Get rate from json rates
     * @param from: currency to convert from
     * @param to: currency to convert to
     * @return NSURLSessionDataTask, to be able to cancel the network call
     */
    class func exchangeRateData(from: Currency, to: Currency, completion: (data: NSData?, error: NSError?) -> Void) -> NSURLSessionDataTask? {
        let urlString = "https://jsonrates.com/get/?from=\(from.rawValue)&to=\(to.rawValue)&apiKey=\(Constants.JSON_RATES_API_KEY)"
        return data(urlString, completion: completion)
    }
    
    
    /**
     * Get data from URL
     * @param urlString: String with URL from get the data
     * @return NSURLSessionDataTask, to be able to cancel the network call
     */
    class func data(urlString: String, completion: (data: NSData?, error: NSError?) -> Void) -> NSURLSessionDataTask? {
        
        var dataTask : NSURLSessionDataTask? = nil
        
        if let url = NSURL(string: urlString) {
            dataTask = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                completion(data: data, error: error)
            })
            // start download
            dataTask?.resume()
            
        } else {
            completion(data: nil, error: NSError(domain: ERROR_DOMAIN, code: WRONG_URL_FORMAT_ERROR_CODE, userInfo: [NSLocalizedDescriptionKey : "Could not create URL from \(urlString)"]))
        }
        
        return dataTask
    }
    
}
