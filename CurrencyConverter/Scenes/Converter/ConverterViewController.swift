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

        navigationController?.navigationBar.customize(supportsLargeTitle: true)
        
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
        case .updateTitle(let title):
            self.title = title
        case .showLoading(let isLoading):
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        case .showLatestRates(let presentation):
            self.rates = presentation.rates
            self.tableView.reloadData()
        }
    }
    
    func navigate(to route: ConverterViewRoute) {
        let viewController = CurrencyListBuilder.make()
        let navigationController = UINavigationController(rootViewController: viewController)
        show(navigationController, sender: self)
    }
}

extension ConverterViewController: UITableViewDataSource {
  
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
        cell.detailTextLabel?.text = String(rate.value)

        return cell
    }
}

extension ConverterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.addCurrency()
    }
}
