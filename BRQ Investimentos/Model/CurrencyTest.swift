//
//  CurrencyTest.swift
//  BRQ Investimentos
//
//  Created by Henrique Silva on 15/09/21.
//

import Foundation

struct CurrencyTest {
    let name: String?
    let buy: Double
    let sell: Double?
    let variation: Double?
    
    init(name: String, buy: Double, sell: Double, variation: Double) {
        self.name = name
        self.buy = buy
        self.sell = sell
        self.variation = variation
    }
}
