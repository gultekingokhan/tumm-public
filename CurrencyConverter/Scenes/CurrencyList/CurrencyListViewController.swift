//
//  CurrencyListViewController.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 14.12.2018.
//  Copyright © 2018 Gokhan Gultekin. All rights reserved.
//

import UIKit

final class CurrencyListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: CurrencyListViewModel! {
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

extension CurrencyListViewController: CurrencyListViewModelDelegate {
    
    func handleViewModelOutput(_ output: CurrencyListViewModelOutput) {
        
        switch output {
        case .showLoading(let isLoading):
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        case .showLatestRates(let presentation):
            self.rates = presentation.rates
            self.tableView.reloadData()
        }
    }
    
    func navigate(to route: CurrencyListViewRoute) {
        let viewController = CurrencyListBuilder.make()
        show(viewController, sender: self)
    }
}

extension CurrencyListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath)
        
        let rate = rates[indexPath.row]
        
        cell.textLabel?.text = rate.symbol
        cell.detailTextLabel?.text = rate.country.name
        
        return cell
    }
}

extension CurrencyListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //viewModel.addCurrency()
    }
}
