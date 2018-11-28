//
//  SubscriptionViewController.swift
//  LiveWallpapers
//
//  Created by Vladyslav Gamalii on 10/17/18.
//  Copyright © 2018 Codex. All rights reserved.
//

import UIKit

final class SubscriptionViewController: UIViewController {
    
    // MARK: - Properties
    
    var didCompleteSubscription: EmptyCompletion?

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - IBActions
    
    @IBAction func closeAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func restoreAction(_ sender: UIButton) {
        restoreSubscription()
    }
    
    // MARK: - Public Methods
    
    func showTermsConditions() {
        performSegue(withIdentifier: TremsConditionsViewController.storyboardIdentifier, sender: TermsPrivacyType.termsConditions)
    }
    
    func showPrivacyPolicy() {
        performSegue(withIdentifier: TremsConditionsViewController.storyboardIdentifier, sender: TermsPrivacyType.privacyPolicy)
    }
    
    func startOneMonthSubscription() {
        ShopManager.sharedInstance.buySubscriptionWith(id: Constants.monthlySubscriptionID)
        dismiss(animated: true) { [weak self] in
            self?.didCompleteSubscription?()
        }
    }
    
    func startOneYearSubscription() {
        ShopManager.sharedInstance.buySubscriptionWith(id: Constants.yearlySubscriptionID)
        dismiss(animated: true) { [weak self] in
            self?.didCompleteSubscription?()
        }
    }
    
    func startTrialSubscription() {
        ShopManager.sharedInstance.buySubscriptionWith(id: Constants.subscriptionID)
        dismiss(animated: true) { [weak self] in
            self?.didCompleteSubscription?()
        }
    }
    
    // MARK: - Private
    
    private func restoreSubscription() {
        // TODO: Refactor. Should be handled by Interator.
        ShopManager.sharedInstance.restorePurchase(id: Constants.subscriptionID) { [weak self] (success) in
            if success {
                self?.successRestore()
                ShopManager.sharedInstance.showAlert(title: "Restored", message: "Your subscription has been restored")
            } else {
                ShopManager.sharedInstance.showAlert(title: "Restore", message: "You don't have a memebership to restore.")
            }
        }
    }
    
    
    private func successRestore() {
        UserDefaults.standard.set(true, forKey: Constants.UDsubscriptionEnable)
        dismiss(animated: true) { [weak self] in
            self?.didCompleteSubscription?()
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? TremsConditionsViewController {
            if let termsViewModel = sender as? TermsPrivacyType {
                destinationVC.viewModel = termsViewModel
            }
        }
    }
}

