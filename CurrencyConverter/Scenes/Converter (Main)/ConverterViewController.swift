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
    
    var rates: [String: [Rate]] = [:]
    
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
        return rates.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 { return 0 } else { return 60 }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        var key = RateType.SELL.rawValue
        
        if section == 1 { key = RateType.BUY.rawValue }
        
        return rates[key]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConverterRatesCell", for: indexPath) as! ConverterRatesCell

        var key = RateType.SELL.rawValue
        
        if indexPath.section == 1 { key = RateType.BUY.rawValue }

        if let _rates = rates[key] {
            
            let rate = _rates[indexPath.row]
            
            cell.codeLabel?.text = rate.code
            cell.valueLabel?.text = String(format: "%.2f", rate.value!)
        }

        return cell
    }
}

extension ConverterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ConverterRatesHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 28))
        
        if section == 0 {
            view.titleLabel?.text = RateType.SELL.rawValue
        } else {
            view.titleLabel?.text = RateType.BUY.rawValue
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = ConverterRatesFooterView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 60))
        footerView.delegate = self
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.addCurrency()
    }
}

extension ConverterViewController: ConverterRatesFooterViewDelegate {
    
    func addCurrencyButtonTapped() {
        viewModel.addCurrency()
    }
}
