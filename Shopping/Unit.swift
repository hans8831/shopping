//
//  Unit.swift
//  Shopping
//
//  Created by Roland Michelberger on 14/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//


enum Unit : String {
    case Can = "can"
    case Dozen = "dozen"
    case Bag = "bag"
    case Bottle = "bottle"
    case Unknown = "unknown"
    
}

extension Unit {
    init(string: String) {
        switch string {
        case "bag": self = .Bag
        case "bottle": self = .Bottle
        case "can": self = .Can
        case "dozen": self = .Dozen
        default: self = .Unknown
        }
    }
}