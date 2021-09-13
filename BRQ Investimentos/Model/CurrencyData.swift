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
    
}
