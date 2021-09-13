//
//  Moedas.swift
//  BRQ Investimentos
//
//  Created by Henrique Silva on 10/09/21.
//

import Foundation

struct Currency {
    let ISOname: String
    let variation: Double
    
    init (ISOname: String, variation: Double) {
        self.ISOname = ISOname
        self.variation = variation
    }
}
