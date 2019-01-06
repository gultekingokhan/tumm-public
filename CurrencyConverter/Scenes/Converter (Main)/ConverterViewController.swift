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
    private let refreshControl = UIRefreshControl()

    var viewModel: ConverterViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    var rates: [String: [Rate]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StoreReviewHelper.checkAndAskForReview()
        
        customizeViews()
        viewModel.load()
    }
    
    func customizeViews () {
        navigationController?.navigationBar.customize(supportsLargeTitle: true)
        tableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.interactive
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
        
        let settingsButtonItem = UIBarButtonItem(image: UIImage(named: "settingsIcon"), style: .plain, target: self, action: #selector(preferencesButtonTapped))
        settingsButtonItem.tintColor = UIColor.rosyPink
        navigationItem.rightBarButtonItem = settingsButtonItem
    }
    
    @objc func preferencesButtonTapped() {
        navigate(to: .preferences())
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
            print("TEXT: \(text)")
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
        case .showErrorAlertView:
            let alertController = UIAlertController(title: "Error", message: "An error occured while fetching latest rates", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Try again", style: .default, handler: { (_) in
                self.viewModel.load()
            })
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func navigate(to route: ConverterViewRoute) {
        
        switch route {
        case .currencyList(let viewModel):
            let viewController = CurrencyListBuilder.make(with: viewModel)
            viewController.delegate = self
            let navigationController = UINavigationController(rootViewController: viewController)
            show(navigationController, sender: self)
        case .preferences(_):
            let viewController = PreferencesBuilder.make()
            navigationController?.pushViewController(viewController, animated: true)
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

        var key = ""

        switch indexPath.section {
        case 0:
            cell.rateTextField?.delegate = self
            key = RateType.SELL.rawValue
        case 1:
            key = RateType.BUY.rawValue
        default: break
        }
        
        if let _rates = rates[key] {
            
            let rate = _rates[indexPath.row]
           
            cell.loadData(indexPath: indexPath, rate: rate)
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
        
        var key = RateType.SELL.rawValue
        
        if indexPath.section == 1 { key = RateType.BUY.rawValue }
    
        if let _rates = rates[key] {
            let rate = _rates[indexPath.row]
            viewModel.updateSavedCurrencies(with: RateType(rawValue: key)!,
                                            isUpdating: true,
                                            selectedRate: rate)
        }
    }
}

extension ConverterViewController: ConverterRatesFooterViewDelegate {
    
    func addCurrencyButtonTapped() {
        viewModel.updateSavedCurrencies(with: .BUY, isUpdating: false, selectedRate: nil)
    }
}

extension ConverterViewController: CurrencyListViewControllerDelegate {
    @objc func updateData() {
        refreshControl.endRefreshing()
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
