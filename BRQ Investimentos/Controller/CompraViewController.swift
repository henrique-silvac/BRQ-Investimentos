//
//  CompraViewController.swift
//  BRQ Investimentos
//
//  Created by Henrique Silva on 21/09/21.
//

import UIKit

class CompraViewController: UIViewController {
    
    //MARK: - @IBOutlets
    
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var homeButton: UICustomButton!
//    @IBAction func homeButtonPressed(_ sender: UICustomButton) {
//        navigationController?.popToRootViewController(animated: true)
//    }
    
    //MARK: - Properties
    
    var message: String?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Compra"
        
    }
    
}
