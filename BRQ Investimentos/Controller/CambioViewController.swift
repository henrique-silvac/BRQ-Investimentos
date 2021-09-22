//
//  CambioViewController.swift
//  BRQ Investimentos
//
//  Created by Henrique Silva on 14/09/21.
//

import UIKit

class CambioViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - @IBOutlets
    
    @IBOutlet var labelsView: UICustomView!
    
    @IBOutlet var ISOLabel: UILabel!
    @IBOutlet var variationLabel: UILabel!
    @IBOutlet var buyLabel: UILabel!
    @IBOutlet var sellLabel: UILabel!
    
    @IBOutlet var balanceLabel: UILabel!
    @IBOutlet var cashLabel: UILabel!
    
    @IBOutlet var amountTextField: UICustomTextField! {
        didSet {
            amountTextField?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTapped)))
        }
    }
    
    @IBOutlet var sellButton: UICustomButton!
    @IBOutlet var buyButton: UICustomButton!
    
    @IBAction func sellButtonTapped(_ sender: UICustomButton) {
        guard let user = user else { return }
        guard let currency = currencySelected else { return }
        guard let stringInputAmount = amountTextField.text else { return }
        guard let intInputAmount = Int(stringInputAmount) else { return }
        guard let sellVC = storyboard?.instantiateViewController(identifier: "VendaViewController") as? VendaViewController else { return }
        
        var message: String?
        
        if sender.tag == 0 {
            user.sell(quantity: intInputAmount, currencyISO, currency)
            message = "Parabéns! Você acabou de vender \(intInputAmount) \(currencyISO) - \(currency.name), totalizando \(user.balanceLabel)"
        }
        
        sellVC.message = message
        navigationController?.pushViewController(sellVC, animated: true)
        
    }
    
    @IBAction func buyButtonTapped(_ sender: UICustomButton) {
        guard let user = user else { return }
        guard let currency = currencySelected else { return }
        guard let stringInputAmount = amountTextField.text else { return }
        guard let intInputAmount = Int(stringInputAmount) else { return }
        guard let buyVC = storyboard?.instantiateViewController(identifier: "CompraViewController") as? CompraViewController else { return }
        
        var message: String?
        
        user.buy(quantity: intInputAmount, currencyISO, currency)
        message = "Parabéns! Você acabou de comprar \(intInputAmount) \(currencyISO) - \(currency.name), totalizando \(user.balanceLabel)"
        
        buyVC.message = message
        navigationController?.pushViewController(buyVC, animated: true)
        
    }
    
    //MARK: - Properties
    
    var currencySelected: Currency?
    
    var currencyISO = String()
    
    var user: User?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Câmbio"
        
        settingLabels()
        labelsView.setBorderView()
        sellButton.settingButton()
        buyButton.settingButton()
        
        amountTextField.setBorderTextField()
        amountTextField.attributedPlaceholder =
            NSAttributedString(string: "Quantidade", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        settingLabels()
        
    }
    
    //MARK: - Setting labels
    
    func settingLabels() {
        guard let currency = currencySelected else { return }
        guard let user = user else { return }
        guard let userCurrencyAmount = user.userWallet[currencyISO] else { return }
        
        ISOLabel.text = currency.name
        variationLabel.text = currency.variationString
        if currency.variation > 0 {
            variationLabel.textColor = UIColor.green
        } else if currency.variation < 0 {
            variationLabel.textColor = UIColor.red
        } else {
            variationLabel.textColor = UIColor.white
        }
        
        buyLabel.text = ("Compra: " + currency.buyString)
        sellLabel.text = ("Venda: " + currency.sellString)
        
        balanceLabel.text = ("\(userCurrencyAmount) \(currencyISO) em caixa")
        cashLabel.text = ("Saldo disponível: \(user.balanceLabel)")
        
        buttonSettings(buyButton, user, currency, iso: currencyISO)
        buttonSettings(sellButton, user, currency, iso: currencyISO)
        
        amountTextField.text = ""
        
    }
    
    //MARK: - Create Buttons
    
    func buttonSettings(_ button: UICustomButton, _ user: User, _ currency: Currency, iso: String) {
        guard let currencyBuyPrice = currency.buy else { return }
        guard let currencyWallet = user.userWallet[iso] else { return }
        guard let stringInputAmount = amountTextField.text else { return }
        
        var totalPrice = Double()
        var userInput = Int()
        
        if let intInputAmount = Int(stringInputAmount) {
            userInput = intInputAmount
            totalPrice = currencyBuyPrice * Double(intInputAmount)
        }
        
        if button.tag == 1 {
            // buy button
            if (user.balance < currencyBuyPrice || user.balance < totalPrice) {
                button.disable()
            } else {
                button.enable()
            }
        } else {
            // sell button
            if (userInput > currencyWallet || currency.sell == nil || currencyWallet == 0) {
                button.disable()
            } else {
                button.enable()
            }
        }
        
        if (stringInputAmount.isEmpty || userInput == 0) {
            button.disable()
        }
    }
    
    //MARK: - Selectors
    
    @objc func doneButtonTapped() {
        amountTextField.resignFirstResponder()
        
    }
    
}

//MARK: - Extensions

extension UITextField {
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))
        
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() { self.resignFirstResponder() }
    @objc func cancelButtonTapped() { self.resignFirstResponder() }
}
