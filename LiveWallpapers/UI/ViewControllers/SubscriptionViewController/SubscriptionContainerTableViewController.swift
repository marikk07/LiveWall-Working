//
//  SubscriptionContainerTableViewController.swift
//  LiveWallpapers
//
//  Created by Vladyslav Gamalii on 10/17/18.
//  Copyright © 2018 Codex. All rights reserved.
//

import UIKit

class SubscriptionContainerTableViewController: UITableViewController {

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
