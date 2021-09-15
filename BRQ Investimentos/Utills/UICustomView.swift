//
//  UICustomView.swift
//  BRQ Investimentos
//
//  Created by Henrique Silva on 15/09/21.
//

import UIKit

class UICustomView: UIView {
    
    func setBorderView() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
    }
}