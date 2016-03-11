//
//  Currency.swift
//  Shopping
//
//  Created by Roland Michelberger on 10/03/16.
//  Copyright © 2016 Roland Michelberger. All rights reserved.
//

enum Currency : String {
    case EUR = "EUR"
    case USD = "USD"
    case CHF = "CHF"
    case Unknown = "unknown"
}

extension Currency {    
    init(string: String) {
        switch string {
        case "EUR": self = .EUR
        case "USD": self = .USD
        case "CHF": self = .CHF
        default: self = .Unknown
        }
    }
}