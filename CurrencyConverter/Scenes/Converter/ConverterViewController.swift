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
    
    var rates: [Currency] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.load(base: "SEK")
    }
    
    @IBAction func allCurrenciesButtonTapped(_ sender: Any) {
        let viewController = CurrencyListBuilder.make()
        present(viewController, animated: true, completion: nil)
    }
    
}

extension ConverterViewController: ConverterViewModelDelegate {
    
    func handleViewModelOutput(_ output: ConverterViewModelOutput) {
        
        switch output {
        case .showLoading(let isLoading):
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        case .showLatestRates(let presentation):
            self.rates = presentation.rates
            self.tableView.reloadData()
        }
    }
}

extension ConverterViewController: UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath)

        let rate = rates[indexPath.row]
        
        cell.textLabel?.text = rate.symbol
        cell.detailTextLabel?.text = String(rate.value)

        return cell
    }
}

