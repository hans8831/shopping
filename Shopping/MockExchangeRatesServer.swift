//
//  MockServer.swift
//  Shopping
//
//  Created by Roland Michelberger on 10/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

import UIKit

class MockExchangeRatesServer: ExchangeRatesServer {
    
    private static var delay = 1.0
    static let JSON_DATA_PATH_NOT_FOUND = -2
    
    override class func exchangeRatesData(sourceCurrency: Currency, completion: (data: NSData?, error: NSError?) -> Void) -> NSURLSessionDataTask? {
        if sourceCurrency == .USD {
            return exchangeRatesDataForUSD(completion)
        } else {
            completion(data: nil, error: NSError(domain: ERROR_DOMAIN, code: -1, userInfo: [NSLocalizedDescriptionKey : "exchangeRatesData(source: \(sourceCurrency)) is not implemented"]))
            return nil
        }
    }
    
    override class func exchangeRatesDataForUSD(completion: (data: NSData?, error: NSError?) -> Void) -> NSURLSessionDataTask? {
        if let filePath = NSBundle.mainBundle().pathForResource("exchangeRates", ofType: "json") {
            let JSONData = NSData(contentsOfFile: filePath)
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) { () -> Void in
                completion(data: JSONData, error: nil)
            }
        } else {
            completion(data: nil, error: NSError(domain: ERROR_DOMAIN, code: JSON_DATA_PATH_NOT_FOUND, userInfo: [NSLocalizedDescriptionKey : "exchangeRates.json file path not found."]))
        }
        
        return nil
    }
    
}
