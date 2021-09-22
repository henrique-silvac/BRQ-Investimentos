//
//  User.swift
//  BRQ Investimentos
//
//  Created by Henrique Silva on 16/09/21.
//

import UIKit

class User {
    
    let defaultAPICurrencies = ["USD", "EUR", "GBP", "ARS", "AUD", "BTC", "CAD", "CNY", "JPY"]
    
    var balance: Double
    
    var userWallet: [String: Int]
    
    var balanceLabel: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "BRL"
        if let result = formatter.string(from: NSNumber(value: balance)) {
            return result
        }
        return "R$0.00"
    }
    
    init() {
        self.balance = 1000
        var wallet = [String: Int]()
        for iso in defaultAPICurrencies {
            wallet[iso] = 0
        }
        self.userWallet = wallet
    }
}
