//
//  UICustomButton.swift
//  BRQ Investimentos
//
//  Created by Henrique Silva on 16/09/21.
//

import UIKit

class UICustomButton: UIButton {
    func settingButton() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 15
    }
    
    func disable() {
        self.isEnabled = false
        self.alpha = 0.45
        settingButton()
    }
    
    func enable() {
        self.isEnabled = true
        self.alpha = 1
        settingButton()
    }
    
}
