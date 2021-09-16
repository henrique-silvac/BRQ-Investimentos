//
//  CambioViewController.swift
//  BRQ Investimentos
//
//  Created by Henrique Silva on 14/09/21.
//

import UIKit

class CambioViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet var labelsView: UICustomView!
    @IBOutlet var amountView: UICustomView!
    
    @IBOutlet var ISOLabel: UILabel!
    @IBOutlet var variationLabel: UILabel!
    @IBOutlet var buyLabel: UILabel!
    @IBOutlet var sellLabel: UILabel!
    
    @IBOutlet var balanceLabel: UILabel!
    @IBOutlet var cashLabel: UILabel!
    
    @IBOutlet var amountLabel: UILabel!
    
    @IBOutlet var sellButton: UICustomButton!
    @IBOutlet var buyButton: UICustomButton!
    
    //MARK: - Properties

    var currencySelected: Currency?
    var user: User?
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Câmbio"
        
        settingLabels()
        labelsView.setBorderView()
        amountView.setBorderView()
        sellButton.settingButton()
        buyButton.settingButton()
    }
    
    //MARK: - 
    
    func settingLabels() {
        guard let currency = currencySelected else { return }
        guard let user = user else { return }
        
        ISOLabel.text = currency.name
        variationLabel.text = currency.variationString
        if currency.variation > 0 {
            variationLabel.textColor = UIColor.systemGreen
        } else if currency.variation < 0 {
            variationLabel.textColor = UIColor.systemRed
        } else {
            variationLabel.textColor = UIColor.white
        }
        
        buyLabel.text = ("Compra: " + currency.buyString)
        sellLabel.text = ("Venda: " + currency.sellString)
        
        balanceLabel.text = ("0 \(currency.name) em caixa")
        cashLabel.text = ("Saldo disponível: \(user.balanceLabel)")
    }
    
    func ButtonPressed(_ sender: UICustomButton) {
        guard let user = user else { return }
        
        if sender.tag == 0 {
            //sell button
            user.balance += 10
        } else {
            //buy button
            user.balance -= 10
        }
        settingLabels()
        
    }

}
