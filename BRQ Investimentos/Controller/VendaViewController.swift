//
//  VendaViewController.swift
//  BRQ Investimentos
//
//  Created by Henrique Silva on 21/09/21.
//

import UIKit

class VendaViewController: UIViewController {
    
    //MARK: - @IBOutlets
    
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var homeButton: UICustomButton!
    
    @IBAction func homeButtonTapped(_ sender: UICustomButton) {
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    //MARK: - Properties
    
    var message: String?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Venda"
        guard let message = message else { return }
        textLabel.text = message
        homeButton.settingButton()
        
    }
    
}
