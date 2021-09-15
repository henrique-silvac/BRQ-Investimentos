//
//  FinanceData.swift
//  BRQ Investimentos
//
//  Created by Henrique Silva on 15/09/21.
//

import Foundation

struct FinanceData: Codable {
    let results: Results
}

struct Results: Codable {
    let currencies: Currencies
}

struct Currencies: Codable {
    let source: String
    let USD, EUR, GBP, ARS, AUD, BTC, CAD, CNY, JPY: Currency
}

struct Currency: Codable {

    let name: String
    let buy: Double?
    let sell: Double?
    let variation: Double
    
}
