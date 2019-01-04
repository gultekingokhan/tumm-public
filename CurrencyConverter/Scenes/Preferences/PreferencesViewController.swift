//
//  PreferencesViewController.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 3.01.2019.
//  Copyright © 2019 Gokhan Gultekin. All rights reserved.
//

import UIKit

final class PreferencesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var versionLabel: UILabel!
    var viewModel: PreferencesViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    var list: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()  // This line was added for removing the seperator lines on empty cells.
        viewModel.load()
    }
}

extension PreferencesViewController: PreferencesViewModelDelegate {
    
    func handleViewModelOutput(_ output: PreferencesViewModelOutput) {
        switch output {
        case .updateTitle(let title):
            self.title = title
        case .showList(let presentation):
            self.list = presentation.list
            self.tableView.reloadData()
        case .updateVersionLabel(let text):
            self.versionLabel.text = text
        case .presentActivityController(let activityViewController):
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
}

extension PreferencesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreferencesCell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
}

extension PreferencesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            viewModel.aboutApp()
            break
        case 1:
            viewModel.openTwitterProfile()
            break
        case 2:
            viewModel.rateApp()
            break
        case 3:
            viewModel.shareApp()
            break
        default:
            break
        }
    }
}
