//
//  PreferencesViewModel.swift
//  CurrencyConverter
//
//  Created by Gokhan Gultekin on 3.01.2019.
//  Copyright © 2019 Gokhan Gultekin. All rights reserved.
//

import UIKit

final class PreferencesViewModel: PreferencesViewModelProtocol {
    
    weak var delegate: PreferencesViewModelDelegate?
    
    private func notify(_ output: PreferencesViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
    
    func load() {
        notify(.updateTitle("Preferences"))
        
        if let appVersionText = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
            notify(.updateVersionLabel("v\(appVersionText)"))
        }

        let list = ["About", "Follow us on Twitter", "Rate us", "Share"]
        let presentation = PreferencesPresentation(list: list)
        notify(.showList(presentation))
    }
    
    func openTwitterProfile() {
        let schemeURL = URL(string: Constants.Links.twitter_scheme)!
        let webURL = URL(string: Constants.Links.twitter_url)!
        
        let application = UIApplication.shared
        
        if application.canOpenURL(schemeURL) {
            application.open(schemeURL as URL)
        } else {
            application.open(webURL as URL)
        }
    }
    
    func rateApp() {
        StoreReviewHelper.askForReviewManually()
    }
    
    func shareApp() {
        let text = "Get Tumm currency converter app on App Store!\n\nConvert multiple currencies with no hassle.\n"
        let url = URL(string: Constants.Links.appStore)
        let activityViewController = UIActivityViewController(activityItems: [text, url!], applicationActivities: nil)
        delegate?.handleViewModelOutput(.presentActivityController(activityViewController))
    }
    
    func aboutApp() {
        
        let url = URL(string: Constants.Links.medium)
        UIApplication.shared.open(url!)
    }
}
