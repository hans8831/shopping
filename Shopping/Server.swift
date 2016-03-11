//
//  Server.swift
//  Shopping
//
//  Created by Roland Michelberger on 10/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

import Foundation

class Server: NSObject {
    
    static let ERROR_DOMAIN = "ch.miro.shopping.Server"
    
    static let WRONG_URL_FORMAT_ERROR_CODE = -1
    
    /**
     * Get rate from json rates
     * @param from: currency to convert from
     * @param to: currency to convert to
     * @return NSURLSessionDataTask, to be able to cancel the network call
     */
    class func exChangeRateData(from: Currency, to: Currency, completion: (data: NSData?, error: NSError?) -> Void) -> NSURLSessionDataTask? {
        
        var dataTask : NSURLSessionDataTask? = nil
        
        if let url = NSURL(string: "https://jsonrates.com/get/?from=\(from.rawValue)&to=\(to.rawValue)&apiKey=\(Constants.JSON_RATES_API_KEY)") {
            dataTask = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                completion(data: data, error: error)                
            })
            // start download
            dataTask?.resume()
            
        } else {
            completion(data: nil, error: NSError(domain: ERROR_DOMAIN, code: WRONG_URL_FORMAT_ERROR_CODE, userInfo: [NSLocalizedDescriptionKey : "Could not create URL for getting the currency rate."]))
        }
        
        return dataTask
    }
    
}
