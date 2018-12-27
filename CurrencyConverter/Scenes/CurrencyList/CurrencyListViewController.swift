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
    var viewModel: CurrencyListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    var rates: Dictionary<String, [Currency]> = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.customize(supportsLargeTitle: false)
        addDismissButton()

        viewModel.load(base: "SEK")
    }
    
    @IBAction func allCurrenciesButtonTapped(_ sender: Any) {
        /*
        let viewController = CurrencyListBuilder.make()
        present(viewController, animated: true, completion: nil)
        */
    }
    
}

extension CurrencyListViewController: CurrencyListViewModelDelegate {
    
    func handleViewModelOutput(_ output: CurrencyListViewModelOutput) {
        
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
    
    func navigate(to route: CurrencyListViewRoute) {
//        let viewController = CurrencyListBuilder.make(with: <#CurrencyListViewModelProtocol#>)
//        show(viewController, sender: self)
    }
}

extension CurrencyListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return rates.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keys: [String] = Array(rates.keys)
        return rates[keys[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as! CurrencyListCell
        
        let key = Array(rates.keys)[indexPath.section]
        let rate = rates[key]![indexPath.row]

        cell.update(themeColor: viewModel.themeColor)
        cell.symbolLabel.text = rate.symbol
        cell.nameLabel.text = rate.country.name
        
        return cell
    }
}

extension CurrencyListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: CurrencyListHeaderView = CurrencyListHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 28))
        
        view.update(themeColor: viewModel.themeColor)
        view.titleLabel?.text = Array(rates.keys)[section]
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let key = Array(rates.keys)[indexPath.section]
        let rate = rates[key]![indexPath.row]

        let rateToSave = Rate(code: rate.symbol, type: .BUY, name: rate.country.name)
        CoreDataHelper.save(rate: rateToSave) { (error) in
            print("ERROR: \(String(describing: error))")
        }
        
        dismiss(animated: true, completion: nil)
    }
}
