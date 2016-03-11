//
//  MockServer.swift
//  Shopping
//
//  Created by Roland Michelberger on 10/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

import UIKit

class MockServer: Server {
    
    static var delay = 1.0

    override class func exChangeRateData(from: Currency, to: Currency, completion: (data: NSData?, error: NSError?) -> Void) -> NSURLSessionDataTask? {
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))

        dispatch_after(delayTime, dispatch_get_main_queue()) { () -> Void in
            // random rate between 0.5 and 1.5
            let rate = Float(arc4random()) / Float(UINT32_MAX) + 0.5
            let data = "{\"utctime\": \"2014-06-26T15:00:03+02:00\",\"from\": \"\(from.rawValue)\",\"to\": \"\(to.rawValue)\",\"rate\": \"\(rate)\"}".dataUsingEncoding(NSUTF8StringEncoding)
            
            completion(data: data, error: nil)
        }
        
        return nil
    }
}
