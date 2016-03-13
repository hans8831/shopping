//
//  JSONParser.swift
//  Shopping
//
//  Created by Roland Michelberger on 10/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

import Foundation

class JSONParser {
    
    static let ERROR_DOMAIN = "roland.michelberger.shopping.JSONParser"
    
    static let RATE_JSON_PARSING_ERROR_CODE = -1
    static let RATE_JSON_WRONG_RESPONSE_FORMAT_ERROR_CODE = -2
    
    /**
     * Get exchange rates from the JSON data reponse
     * @param data: JSON data to be parsed
     * @return exchange rates or error
     */
    class func exchangeRatesFromJSONRateResponseData(data: NSData) -> (exchangeRates: ExchangeRates?, error: NSError?) {
        var result = (exchangeRates: ExchangeRates?, error: NSError?)(nil, nil)
        
        let res = dictFromJSONData(data)
        if let _ = res.error {
            
            result.error = res.error
            
        } else if let dict = res.dict {
            
            if let exchangeRates = ExchangeRates(dict: dict) {
                result.exchangeRates = exchangeRates
            } else {
                result.error = NSError(domain: ERROR_DOMAIN, code: RATE_JSON_PARSING_ERROR_CODE, userInfo: [NSLocalizedDescriptionKey : "exchange rates web service response JSON could not be parsed."])
            }
        } else {
            result.error = NSError(domain: ERROR_DOMAIN, code: RATE_JSON_WRONG_RESPONSE_FORMAT_ERROR_CODE, userInfo: [NSLocalizedDescriptionKey : "exchange rates web service response has not the expected format."])
        }
        
        return result
    }
    
    /**
     * Get dict from the JSON data reponse
     * @param data: JSON data to be parsed
     * @return dict or error
     */
    class func dictFromJSONData(data: NSData) -> (dict: [String: AnyObject]?, error: NSError?) {
        var result = (dict: [String: AnyObject]?, error: NSError?)(nil, nil)
        do {
            result.dict = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? [String : AnyObject]
        } catch {
            result.error = error as NSError
        }
        return result
    }
    
}
