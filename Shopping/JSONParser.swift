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
     * Get rates from the JSON data reponse
     * @param data: JSON data to be parsed
     * @return exchange rates or error
     */
    class func exchangeRatesFromJSONRateResponseData(data: NSData) -> (exchangeRates: ExchangeRates?, error: NSError?) {
        var result = (exchangeRates: ExchangeRates?, error: NSError?)(nil, nil)
        
        do {
            if let dict = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? [String : AnyObject] {
                
                if let exchangeRates = ExchangeRates(dict: dict) {
                    result.exchangeRates = exchangeRates
                } else {
                    result.error = NSError(domain: ERROR_DOMAIN, code: RATE_JSON_PARSING_ERROR_CODE, userInfo: [NSLocalizedDescriptionKey : "exchange rates web service response JSON could not be parsed."])
                }
            } else {
                result.error = NSError(domain: ERROR_DOMAIN, code: RATE_JSON_WRONG_RESPONSE_FORMAT_ERROR_CODE, userInfo: [NSLocalizedDescriptionKey : "exchange rates web service response has not the expected format."])
            }
            
        } catch {
            result.error = error as NSError
        }
        
        return result
    }
    
    
    /**
     * Get rate from the JSON data reponse
     * @param data: JSON data to be parsed
     * @return exchange rate or error
     */
    class func exchangeRateFromJSONRateResponseData(data: NSData) -> (exchangeRate: ExchangeRate?, error: NSError?) {
        var result = (exchangeRate: ExchangeRate?, error: NSError?)(nil, nil)
        do {
            if let dict = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? [String : AnyObject] {
                
                if let exchangeRate = ExchangeRate(dict: dict) {
                    result.exchangeRate = exchangeRate
                } else {
                    result.error = NSError(domain: ERROR_DOMAIN, code: RATE_JSON_PARSING_ERROR_CODE, userInfo: [NSLocalizedDescriptionKey : "JSON rates web service response JSON could not be parsed."])
                }
            } else {
                result.error = NSError(domain: ERROR_DOMAIN, code: RATE_JSON_WRONG_RESPONSE_FORMAT_ERROR_CODE, userInfo: [NSLocalizedDescriptionKey : "JSON rates web service response has not the expected format."])
            }
            
        } catch {
            result.error = error as NSError
        }
        
        return result
    }
    
}
