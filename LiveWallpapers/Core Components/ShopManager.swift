//
//  ShopManager.swift
//  coloringbook
//
//  Created by Iulian Dima on 3/3/17.
//  Copyright © 2017 Tapptil. All rights reserved.
//

import Foundation
import UIKit
import StoreKit

class ShopManager {
    
    static let sharedInstance = ShopManager()
    
    private var container = UIView()
    private var loadingView = UIView()
    private var activityIndicator = UIActivityIndicatorView()
    private var subscriptionRestore = false
    
    var weeklylocalizedPrice = ""
    var monthlylocalizedPrice = ""
    var yearlylocalizedPrice = ""
    
    private init() {}
    
    
    func showActivityIndicator() {
        
        let view = UIApplication.topViewController()!.view!
        
        container.frame = view.bounds
        container.center = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
        container.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = container.center
        loadingView.backgroundColor = UIColor(red:0.40, green:0.95, blue:1.00, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2,
                                           y: loadingView.frame.size.height / 2)
        
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        view.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
    
    
    func showAlert(title: String, message: String, actions:[UIAlertAction]? = nil, closeParentView: Bool = false) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        if let alerts = actions {
            alerts.forEach{ alertController.addAction($0) }
        }else{
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action) in
                if (closeParentView) { UIApplication.topViewController()!.dismiss(animated: true, completion: nil) }
            }
            alertController.addAction(okAction)
        }
        
        UIApplication.topViewController()!.present(alertController, animated: true, completion: nil)
    }
    
    func completeTransactions() {
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.needsFinishTransaction {
                        // Deliver content from server, then:
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                // Unlock content
                case .failed, .purchasing, .deferred:
                    break // do nothing
                }
            }
        }
    }
    
    func buySubscriptionWith(id: String) {
        ShopManager.sharedInstance.showActivityIndicator()
        
        SwiftyStoreKit.purchaseProduct(id) { (result) in
            
            ShopManager.sharedInstance.hideActivityIndicator()
            
            if case .success(let purchase) = result {
                //Purchased
                
                if purchase.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(purchase.transaction)
                }
                
                if purchase.transaction.transactionState == .purchased {
                    DispatchQueue.main.async {
                        self.showMainScreen()
                    }
                }
                
            }else{
                DispatchQueue.main.async {
                    self.showSubscriptionScreen()
                }
                ShopManager.sharedInstance.showAlert(title: "Error", message: "There is an error in the transaction. Please try again.")
            }
        }
    }
    
    func buySubscription() {
        ShopManager.sharedInstance.showActivityIndicator()
        
        SwiftyStoreKit.purchaseProduct(Constants.subscriptionID) { (result) in
            
            ShopManager.sharedInstance.hideActivityIndicator()
            
            if case .success(let purchase) = result {
                //Purchased
                
                if purchase.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(purchase.transaction)
                }
                
                if purchase.transaction.transactionState == .purchased {
                    DispatchQueue.main.async {
                        self.showMainScreen()
                    }
                }
                
            }else{
                DispatchQueue.main.async {
                    self.showSubscriptionScreen()
                }
                ShopManager.sharedInstance.showAlert(title: "Error", message: "There is an error in the transaction. Please try again.")
            }
        }
    }
    
    func showMainScreen() {
        DispatchQueue.main.async {
            UserDefaults.standard.set(true, forKey: Constants.UDsubscriptionEnable)
            ShopManager.sharedInstance.completePurchase()
            let story = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = story.instantiateViewController(withIdentifier: HomeViewController.storyboardIdentifier)
            let navigationVC = UINavigationController.init(rootViewController: vc)
            navigationVC.isNavigationBarHidden = true
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.fadeTransition(0.3)
            appDelegate.window?.rootViewController = navigationVC
        }
    }
    
    private func showSubscriptionScreen() {
        let vc = IAPSubscriptionRouter.getViewController()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = vc
    }
    
    func completePurchase() {
        UserDefaults.standard.set(true, forKey: "hideTrialButton")
        UserDefaults.standard.set(true, forKey: Constants.removeAdsID)
        UserDefaults.standard.set(true, forKey: "subscriptionIsActive")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "didRemoveAdsNotification"), object: nil)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "didPurchaseSubNotification"), object: nil)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "didPurchaseNotification"), object: nil)
        UserDefaults.standard.synchronize()
    }
    
    func restorePurchase(id:String, completion:@escaping (_ success:Bool)->()) {
        SwiftyStoreKit.restorePurchases(atomically: true) { results in
            for product in results.restoredProducts {
                if product.productId == id {
                    completion(true)
                    return
                }
            }
            completion(false)
        }
    }
    
    func verifySubscription(completion: EmptyCompletion? = nil) {
        
        let appleValidator = AppleReceiptValidator(service: Constants.production ? .production : .sandbox)
        SwiftyStoreKit.verifyReceipt(using: appleValidator, password: Constants.sharedSecret) {
            result in
            
            switch result {
            case .success(let receipt):
                // Verify the purchase of a Subscription
                
                var subscriptionIsActive = false
                
                let purchaseWeekSubResult = SwiftyStoreKit.verifySubscription(type: .autoRenewable, productId: Constants.subscriptionID, inReceipt: receipt)
                switch purchaseWeekSubResult {
                case .purchased(let expiresDate):
                    print("Product is valid until \(expiresDate)")
                    subscriptionIsActive = true
                case .expired(let expiresDate):
                    print("Product is expired since \(expiresDate)")
                    if Constants.freeTrialEnabled {
                        UserDefaults.standard.set(true, forKey: "hideTrialButton")
                    }
                case .notPurchased:
                    print("The user has never purchased this product")
                }
                
                if !subscriptionIsActive {

                    UserDefaults.standard.set(false, forKey: Constants.UDsubscriptionEnable)
                    
                    UserDefaults.standard.set(false, forKey: Constants.removeAdsID)
                    UserDefaults.standard.set(false, forKey: "subscriptionIsActive")
                    UserDefaults.standard.synchronize()
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "didExpireSubNotification"), object: nil)
                    
                    let close = UIAlertAction(title: "Close", style: .destructive, handler: { (action) in
                        DispatchQueue.main.async {
                            self.showSubscriptionScreen()
                        }
                    })
                    
                    let buy = UIAlertAction(title: "Buy", style: .default, handler: { (action) in
                        self.buySubscription()
                    })
                    
                    self.showAlert(title: "Subscription", message: "The subscription was expired or cancelled.", actions: [close,buy])
                    
                }else{
                    let value = UserDefaults.standard.bool(forKey: Constants.UDsubscriptionEnable)
                    if !value {
                        let ok = UIAlertAction(title: "Done", style: .default, handler: { (action) in
                            self.showMainScreen()
                        })
                        self.showAlert(title: "Subscription", message: "You have a valid subscription!", actions: [ok])
                    }
                    UserDefaults.standard.set(true, forKey: Constants.UDsubscriptionEnable)
                }
                
            case .error(let error):
                print("Receipt verification failed: \(error)")
            }
        }
    }
    
}
