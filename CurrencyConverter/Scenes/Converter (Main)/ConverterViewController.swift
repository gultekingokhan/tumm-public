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
    
    var rates: [Rate] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.customize(supportsLargeTitle: true)
        addSettingsButton()
        
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
        case .showConverterRates(let presentation):
            self.rates = presentation.rates
            self.tableView.reloadData()
        case .showLatestRates(_):
            break
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
       
        if section == 0 { return 1 } else { return rates.count-1 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConverterRatesCell", for: indexPath) as! ConverterRatesCell

        let rate = rates[indexPath.row]
        
        cell.codeLabel?.text = rate.code
        cell.valueLabel?.text = "1,00"

        return cell
    }
}

extension ConverterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ConverterRatesHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 28))
        
        if section == 0 {
            view.titleLabel?.text = "SELL"
        } else {
            view.titleLabel?.text = "BUY"
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.addCurrency()
    }
}
