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
        
        viewModel.load()
    }
    
    @IBAction func allCurrenciesButtonTapped(_ sender: Any) {
//        let viewController = CurrencyListBuilder.make(with: <#CurrencyListViewModelProtocol#>)
//        present(viewController, animated: true, completion: nil)
    }
    
}

extension ConverterViewController: ConverterViewModelDelegate {

    func check(string: String) -> Bool {
       
        var text = string
        
        let numberOfDots = text.components(separatedBy: ",").count - 1
        
        let numberOfDecimalDigits: Int
        if let dotIndex = text.index(of: ",") {
            numberOfDecimalDigits = text.distance(from: dotIndex, to: text.endIndex) - 1
        } else {
            numberOfDecimalDigits = 0
        }

        if numberOfDots <= 1 && numberOfDecimalDigits <= 4 {
            
            text = text.replacingOccurrences(of: ",", with: ".")
            
            if text.count > 0 {
                
                if text.first == "." { return false }
                viewModel.updateRateValues(value: Double(text)!)
            } else {
                viewModel.updateRateValues(value: 0)
            }
            
            return true
        } else { return false }
    }
    
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
        case .showUpdatedRates(let presentation):
            self.rates = presentation.rates
            self.tableView.reloadSections([1], with: .none)
        }
    }
    
    func navigate(to route: ConverterViewRoute) {
        
        switch route {
        case .currencyList(let viewModel):
            let viewController = CurrencyListBuilder.make(with: viewModel)
            viewController.delegate = self
            let navigationController = UINavigationController(rootViewController: viewController)
            show(navigationController, sender: self)
        }
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
          
            var valueString = ""
            
            if let value = rate.value {
                valueString = String(format: "%.2f", value)
            }
            
            if indexPath.section == 0 {
                cell.valueLabel.isHidden = true
                cell.rateTextField?.isHidden = false
                cell.rateTextField?.text = valueString
                cell.rateTextField?.delegate = self
            } else {
                cell.valueLabel.isHidden = false
                cell.rateTextField?.isHidden = true
                cell.valueLabel?.text = valueString
            }
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
        return footerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var rateType = RateType.SELL.rawValue
        if indexPath.section == 1 { rateType = RateType.BUY.rawValue }

        viewModel.addCurrency(with: RateType(rawValue: rateType)!)
    }
}

extension ConverterViewController: ConverterRatesFooterViewDelegate {
    
    func addCurrencyButtonTapped() {
        viewModel.addCurrency(with: .BUY)
    }
}

extension ConverterViewController: CurrencyListViewControllerDelegate {
    func updateData() {
        viewModel.load()
    }
}

extension ConverterViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let oldText = textField.text, let r = Range(range, in: oldText) else {
            return true
        }
        
        let newText = oldText.replacingCharacters(in: r, with: string)
        
        return check(string: newText)
    }
}
