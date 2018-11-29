//
//  SubscriptionContainerTableViewController.swift
//  LiveWallpapers
//
//  Created by Vladyslav Gamalii on 10/17/18.
//  Copyright © 2018 Codex. All rights reserved.
//

import UIKit

class SubscriptionContainerTableViewController: UITableViewController {
    
    private var subscriptionPrice: String = "$7.99" //407080 id
    private var monthlySubscriptionID: String = "$19.99" //203040 id
    private var yearlySubscriptionID: String = "$49.99" //507080 id
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocalisePrice()
    }
    
    // MARK: - Private Methods
    
    func checkLocalisePrice() {
        SwiftyStoreKit.retrieveProductsInfo([Constants.subscriptionID, Constants.monthlySubscriptionID, Constants.yearlySubscriptionID]) { result in
            for product in result.retrievedProducts {
                if product.productIdentifier == Constants.subscriptionID {
                    self.subscriptionPrice = product.localizedPrice ?? "$7.99"
                } else if product.productIdentifier == Constants.monthlySubscriptionID {
                    self.monthlySubscriptionID = product.localizedPrice ?? "$19.99"
                } else if product.productIdentifier == Constants.yearlySubscriptionID {
                    self.yearlySubscriptionID = product.localizedPrice ?? "$49.99"
                }
            }
            self.priceWeekLabel.text = "then " + self.subscriptionPrice + " per week"
            self.monthButtonPrice.text = self.monthlySubscriptionID
            self.yearButtonPrice.text = self.yearlySubscriptionID
            self.priceAsLowLabel.text = "Price: as low as " + self.subscriptionPrice + " per week."
        }
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var weekView: UIView! {
        didSet {
            weekView.layer.borderWidth = 2
            weekView.layer.borderColor = UIColor(hex: 0x304FFD, alpha: 1).cgColor
        }
    }
    @IBOutlet weak var yearView: UIView! {
        didSet {
            yearView.layer.borderWidth = 2
            yearView.layer.borderColor = UIColor(hex: 0x00BFA5, alpha: 1).cgColor
        }
    }
    
    @IBOutlet weak var priceWeekLabel: UILabel!
    @IBOutlet weak var monthButtonPrice: UILabel!
    @IBOutlet weak var yearButtonPrice: UILabel!
    @IBOutlet weak var priceAsLowLabel: UILabel!
    
    
    // MARK: - IBActions
    
    @IBAction func startFreeTrialAction(_ sender: UIButton) {
        guard let parent = parent as? SubscriptionViewController else { return }
        parent.startTrialSubscription()
    }
    
    @IBAction func monthViewAction(_ sender: UIButton) {
        guard let parent = parent as? SubscriptionViewController else { return }
        parent.startOneMonthSubscription()
    }
    
    @IBAction func yearViewAction(_ sender: UIButton) {
        guard let parent = parent as? SubscriptionViewController else { return }
        parent.startOneYearSubscription()
    }
    
    @IBAction func privacyPolicyAction(_ sender: UIButton) {
        guard let parent = parent as? SubscriptionViewController else { return }
        parent.showPrivacyPolicy()
    }
    
    @IBAction func termsAction(_ sender: UIButton) {
        guard let parent = parent as? SubscriptionViewController else { return }
        parent.showTermsConditions()
    }
    
}
