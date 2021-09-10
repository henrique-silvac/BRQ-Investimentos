//
//  HomeTableViewController.swift
//  BRQ Investimentos
//
//  Created by Henrique Silva on 10/09/21.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    //MARK: - Constants
    
    var Coins: [Currency] = [Currency(name: "", body: "")]
    var cellHeightSpacing = 24

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Coins.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(cellHeightSpacing)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! CurrencyTableViewCell
        
        cell.textLabel?.text = Coins[indexPath.row].body
        
        cell.cellView.layer.borderWidth = 1
        cell.cellView.layer.borderColor = UIColor.white.cgColor
        cell.cellView.layer.cornerRadius = 26
        cell.cellView.clipsToBounds = true
        
        return cell
    }

}
