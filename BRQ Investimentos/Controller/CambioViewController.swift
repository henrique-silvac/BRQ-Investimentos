//
//  CambioViewController.swift
//  BRQ Investimentos
//
//  Created by Henrique Silva on 14/09/21.
//

import UIKit

class CambioViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - IBOutlets
    
    @IBOutlet var labelsView: UICustomView!
    
    @IBOutlet var ISOLabel: UILabel!
    @IBOutlet var variationLabel: UILabel!
    @IBOutlet var buyLabel: UILabel!
    @IBOutlet var sellLabel: UILabel!
    
    @IBOutlet var balanceLabel: UILabel!
    @IBOutlet var cashLabel: UILabel!
    
    @IBOutlet var amountTextField: UITextField! {
        didSet {
                amountTextField?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForMyNumericTextField)))
            }
    }
    
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
        sellButton.settingButton()
        buyButton.settingButton()
        
        amountTextField.layer.cornerRadius = 15
        amountTextField.layer.borderWidth = 1
        amountTextField.layer.borderColor = UIColor.white.cgColor
        amountTextField.attributedPlaceholder =
            NSAttributedString(string: "Quantidade", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
    }
    
    //MARK: - Detail labels
    
    func settingLabels() {
        guard let currency = currencySelected else { return }
        guard let user = user else { return }
        
        ISOLabel.text = currency.name
        variationLabel.text = currency.variationString
        if currency.variation > 0 {
            variationLabel.textColor = UIColor(red: 122, green: 198, blue: 79, alpha: 1)
        } else if currency.variation < 0 {
            variationLabel.textColor = UIColor(red: 208, green: 2, blue: 27, alpha: 1)
        } else {
            variationLabel.textColor = UIColor.white
        }
        
        buyLabel.text = ("Compra: " + currency.buyString)
        sellLabel.text = ("Venda: " + currency.sellString)
        
        balanceLabel.text = ("0 \(currency.name) em caixa")
        cashLabel.text = ("Saldo disponível: \(user.balanceLabel)")
    }
    
    @objc func doneButtonTappedForMyNumericTextField() {
        print("Done");
        amountTextField.resignFirstResponder()
    }
    
    //MARK: - Create Buttons
    
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

    // Default actions:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
    @objc func cancelButtonTapped() { self.resignFirstResponder() }
}
