//
//  User.swift
//  BRQ Investimentos
//
//  Created by Henrique Silva on 16/09/21.
//

import UIKit

class User {
    var balance: Double
    
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
    }
}
