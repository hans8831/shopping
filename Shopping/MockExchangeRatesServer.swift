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
    
    override class func exchangeRatesData(source: Currency, completion: (data: NSData?, error: NSError?) -> Void) -> NSURLSessionDataTask? {
        if source == .USD {
            return exchangeRatesDataForUSD(completion)
        } else {
            completion(data: nil, error: NSError(domain: ERROR_DOMAIN, code: -1, userInfo: [NSLocalizedDescriptionKey : "exchangeRatesData(source: \(source)) is not implemented"]))
            return nil
        }
    }
    
    override class func exchangeRatesDataForUSD(completion: (data: NSData?, error: NSError?) -> Void) -> NSURLSessionDataTask? {
        let string = "{\"success\":true,\"terms\":\"https://currencylayer.com/terms\",\"privacy\":\"https://currencylayer.com/privacy\",\"timestamp\":1457684474,\"source\":\"USD\",\"quotes\":{\"USDAED\":3.67295,\"USDAFN\":68.250067,\"USDALL\":123.304497,\"USDAMD\":490.730011,\"USDANG\":1.789959,\"USDAOA\":158.830002,\"USDARS\":15.33095,\"USDAUD\":1.334152,\"USDAWG\":1.79,\"USDAZN\":1.665498,\"USDBAM\":1.754504,\"USDBBD\":2,\"USDBDT\":76.876953,\"USDBGN\":1.75695,\"USDBHD\":0.37691,\"USDBIF\":1559.099976,\"USDBMD\":1.00005,\"USDBND\":1.375697,\"USDBOB\":6.839728,\"USDBRL\":3.609014,\"USDBSD\":0.980925,\"USDBTC\":0.002382,\"USDBTN\":67.095001,\"USDBWP\":10.88495,\"USDBYR\":20675,\"USDBZD\":1.995029,\"USDCAD\":1.32725,\"USDCDF\":927.999935,\"USDCHF\":0.98605,\"USDCLF\":0.024605,\"USDCLP\":664.374983,\"USDCNY\":6.49635,\"USDCOP\":3220.98999,\"USDCRC\":534.429993,\"USDCUC\":1.00008,\"USDCUP\":1.00005,\"USDCVE\":98.584999,\"USDCZK\":24.304501,\"USDDJF\":177.770004,\"USDDKK\":6.70145,\"USDDOP\":45.429705,\"USDDZD\":110.175003,\"USDEEK\":14.120144,\"USDEGP\":7.833301,\"USDERN\":16.180068,\"USDETB\":21.34402,\"USDEUR\":0.898432,\"USDFJD\":2.11465,\"USDFKP\":0.659803,\"USDGBP\":0.701213,\"USDGEL\":2.424969,\"USDGGP\":0.70076,\"USDGHS\":3.870114,\"USDGIP\":0.703903,\"USDGMD\":39.169998,\"USDGNF\":7498.899902,\"USDGTQ\":7.702495,\"USDGYD\":207.210007,\"USDHKD\":7.760701,\"USDHNL\":22.625099,\"USDHRK\":6.7993,\"USDHTG\":61.722801,\"USDHUF\":278.839996,\"USDIDR\":13070,\"USDILS\":3.87355,\"USDIMP\":0.70076,\"USDINR\":67.114998,\"USDIQD\":1107.099976,\"USDIRR\":30211.999761,\"USDISK\":126.230003,\"USDJEP\":0.70076,\"USDJMD\":121.669998,\"USDJOD\":0.709498,\"USDJPY\":113.810501,\"USDKES\":101.442001,\"USDKGS\":72.599098,\"USDKHR\":3925.949951,\"USDKMF\":441.325653,\"USDKPW\":900.000318,\"USDKRW\":1192.814941,\"USDKWD\":0.30068,\"USDKYD\":0.820317,\"USDKZT\":337.634949,\"USDLAK\":7972.249902,\"USDLBP\":1509.900024,\"USDLKR\":142.285004,\"USDLRD\":84.660004,\"USDLSL\":15.21825,\"USDLTL\":3.048704,\"USDLVL\":0.62055,\"USDLYD\":1.36495,\"USDMAD\":9.75555,\"USDMDL\":19.844999,\"USDMGA\":3146.699951,\"USDMKD\":55.240002,\"USDMMK\":1214.050049,\"USDMNT\":2046.500169,\"USDMOP\":7.994699,\"USDMRO\":342.999646,\"USDMUR\":35.599998,\"USDMVR\":15.380418,\"USDMWK\":697.26001,\"USDMXN\":17.719151,\"USDMYR\":4.08595,\"USDMZN\":50.709999,\"USDNAD\":15.21825,\"USDNGN\":198.990005,\"USDNIO\":28.193899,\"USDNOK\":8.50465,\"USDNPR\":107.351997,\"USDNZD\":1.495898,\"USDOMR\":0.385,\"USDPAB\":0.980815,\"USDPEN\":3.426965,\"USDPGK\":3.064403,\"USDPHP\":46.610993,\"USDPKR\":104.624968,\"USDPLN\":3.88645,\"USDPYG\":5719.999478,\"USDQAR\":3.64135,\"USDRON\":4.00995,\"USDRSD\":110.739998,\"USDRUB\":70.362999,\"USDRWF\":768,\"USDSAR\":3.75005,\"USDSBD\":7.966094,\"USDSCR\":13.02395,\"USDSDG\":6.097498,\"USDSEK\":8.36355,\"USDSGD\":1.37681,\"USDSHP\":0.703901,\"USDSLL\":4067.99953,\"USDSOS\":602.799988,\"USDSRD\":3.999996,\"USDSTD\":21898.5,\"USDSVC\":8.727203,\"USDSYP\":219.856995,\"USDSZL\":15.21825,\"USDTHB\":35.154999,\"USDTJS\":7.869601,\"USDTMT\":3.5,\"USDTND\":2.01915,\"USDTOP\":2.220904,\"USDTRY\":2.876801,\"USDTTD\":6.572897,\"USDTWD\":32.805971,\"USDTZS\":2144.850098,\"USDUAH\":25.549999,\"USDUGX\":3359.999975,\"USDUSD\":1,\"USDUYU\":31.775009,\"USDUZS\":2856.639893,\"USDVEF\":6.350166,\"USDVND\":22287,\"USDVUV\":110.730003,\"USDWST\":2.588078,\"USDXAF\":588.434204,\"USDXAG\":0.063959,\"USDXAU\":0.000786,\"USDXCD\":2.740595,\"USDXDR\":0.71625,\"USDXOF\":588.434204,\"USDXPF\":107.047951,\"USDYER\":214.889999,\"USDZAR\":15.2163,\"USDZMK\":5156.08816,\"USDZMW\":11.379899,\"USDZWL\":322.355011}}"
        return dataFromString(string, completion: completion)
    }
    
    class func dataFromString(string: String, completion: (data: NSData?, error: NSError?) -> Void) -> NSURLSessionDataTask? {
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
        
        dispatch_after(delayTime, dispatch_get_main_queue()) { () -> Void in
            let data = string.dataUsingEncoding(NSUTF8StringEncoding)
            completion(data: data, error: nil)
        }
        
        return nil
    }
    
}
