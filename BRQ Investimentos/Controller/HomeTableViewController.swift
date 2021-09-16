//
//  HomeTableViewController.swift
//  BRQ Investimentos
//
//  Created by Henrique Silva on 10/09/21.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    //MARK: - Properties
    
    public let baseURL = "https://api.hgbrasil.com/finance?&key=7bf8e6a7"
    
    var currencies: [Currency] = []
    var timer: Timer?
    
    let cellSpacingHeight: CGFloat = 24
    let user = User()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchData()
        
        timer = Timer.scheduledTimer(withTimeInterval: 216, repeats: true) { [weak self] _ in
            self?.fetchData()
        }
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? HomeTableViewCell else { fatalError() }
        
        settingLabels(cell, for: indexPath)
        cell.labelsView.setBorderView()
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cambioVC = storyboard?.instantiateViewController(identifier: "CambioViewController") as? CambioViewController {
            cambioVC.currencySelected = currencies[indexPath.section]
            cambioVC.user = user
            navigationController?.pushViewController(cambioVC, animated: true)
        }

    }
        
    //MARK: - Creating a Cell
    
    func settingLabels(_ cell: HomeTableViewCell, for indexPath: IndexPath) {
        let currency = currencies[indexPath.section]
        switch currency.name {
        case "Dollar":
            cell.ISOLabel.text = "USD"
        case "Euro":
            cell.ISOLabel.text = "EUR"
        case "Pound Sterling":
            cell.ISOLabel.text = "GBP"
        case "Argentine Peso":
            cell.ISOLabel.text = "ARS"
        case "Canadian Dollar":
            cell.ISOLabel.text = "CAD"
        case "Australian Dollar":
            cell.ISOLabel.text = "AUD"
        case "Japanese Yen":
            cell.ISOLabel.text = "JPY"
        case "Renminbi":
            cell.ISOLabel.text = "CNY"
        case "Bitcoin":
            cell.ISOLabel.text = "BTC"
        default:
            break
        }
        
        if currency.variation > 0.0 {
            cell.variationLabel.textColor = UIColor.green
        } else if currency.variation == 0.0 {
            cell.variationLabel.textColor = UIColor.white
        } else {
            cell.variationLabel.textColor = UIColor.red
        }
        
        cell.variationLabel.text = currency.variationString
    }
    
    //MARK: - API
    
    func fetchData() {
        guard let url = URL(string: baseURL) else { return }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                guard let error = error else { return }
                print(error)
                return
            }
            if let safeData = data {
                self.parseJSON(safeData)
            }
        }
        task.resume()
    }
    
    func parseJSON(_ financeData: Data){
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(FinanceData.self, from: financeData)
            print(decodedData)
            currencies = [
                decodedData.results.currencies.USD,
                decodedData.results.currencies.EUR,
                decodedData.results.currencies.ARS,
                decodedData.results.currencies.AUD,
                decodedData.results.currencies.BTC,
                decodedData.results.currencies.CAD,
                decodedData.results.currencies.CNY,
                decodedData.results.currencies.GBP,
                decodedData.results.currencies.JPY
            ]
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("error parsing json: \(error)")
            return
        }
    }
    
}
