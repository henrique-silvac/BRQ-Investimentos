//
//  UICustomTextField.swift
//  BRQ Investimentos
//
//  Created by Henrique Silva on 17/09/21.
//

import UIKit

class UICustomTextField: UITextField {
    
    func setBorderTextField() {
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor

    }
}
