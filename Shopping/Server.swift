//
//  Server.swift
//  Shopping
//
//  Created by Roland Michelberger on 10/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

import Foundation

class Server {
    
    static let ERROR_DOMAIN = "roland.michelberger.shopping.Server"
    
    static let WRONG_URL_FORMAT_ERROR_CODE = -1

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
