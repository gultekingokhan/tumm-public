//
//  ConverterViewController.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 13.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import UIKit

final class ConverterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: ConverterViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    var rates: [String:Double] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.load(base: "SEK")
    }
}

extension ConverterViewController: ConverterViewModelDelegate {
    
    func handleViewModelOutput(_ output: ConverterViewModelOutput) {
        
        switch output {
        case .showLoading(let isLoading):
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        case .showLatestRates(let presentation):
            //print("rates: \(presentation.rates)")
            self.rates = presentation.rates
            
            
            
            self.tableView.reloadData()
        }
    }
}

extension ConverterViewController: UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath)
        
        let keys = [String](rates.keys)
        
        let key: String = keys[indexPath.row]
        cell.textLabel?.text = key
        
        if let value = rates[key] {
            cell.detailTextLabel?.text = String(format: "%f", value)
        } else {
            cell.detailTextLabel?.text = "-"
        }
        return cell
    }
}

