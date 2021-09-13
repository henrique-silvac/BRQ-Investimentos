//
//  HomeTableViewController.swift
//  BRQ Investimentos
//
//  Created by Henrique Silva on 10/09/21.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    //MARK: - Properties
    
    let baseURL = "https://api.hgbrasil.com/finance"
    
    var currencies: [CurrencyData] = []
    //["USD","EUR","GBP","ARS","CAD","AUD","JPY","CNY","BTC"]
    public let APIKey = "7bf8e6a7"
    
    let cellSpacingHeight: CGFloat = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchData(url: baseURL)
        
        var currency: CurrencyData
        currency = CurrencyData(name: "USD", buy: 0, sell: 0, variation: 0)
        currencies.append(currency)
        
    }

    // MARK: - Table view data source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let name: CurrencyData = currencies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! CurrencyTableViewCell
        
        cell.ISOLabel.text = name.name
        
        cell.cellView.layer.borderWidth = 1
        cell.cellView.layer.borderColor = UIColor.white.cgColor
        cell.cellView.layer.cornerRadius = 26
        cell.cellView.clipsToBounds = true
        
        return cell
    }
    
    //MARK: - Data
    
    func fetchData(url: String) {

        let url = URL(string: url)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                self.parseJSON(json: data)
            } else {
                print("error")
            }
        }
        task.resume()
    }
    
    //MARK: - JSON
    
    func parseJSON(json: Data) {

        do {
            if let json = try JSONSerialization.jsonObject(with: json, options: .mutableContainers) as? [String: Any] {
                print(json)
                if let askValue = json["ask"] as? NSNumber {
                    print(askValue)
                }
            }
        } catch {
            print("error parsing json: \(error)")
        }
    }

}
