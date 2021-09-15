//
//  CurrencyData.swift
//  BRQ Investimentos
//
//  Created by Henrique Silva on 13/09/21.
//

import Foundation

struct CurrencyData: Codable {
    let name: String?
    let buy: Double
    let sell: Double?
    let variation: Double?
    
    init?(json: [String: Any]) {
        guard let buy = json["buy"] as? Double,
              let name = json["name"] as? String,
              let sell = json["name"] as? Double,
              let variation = json["variation"] as? Double
        else {return nil}
        
        self.buy = buy
        self.name = name
        self.sell = sell
        self.variation = variation
    }
}
