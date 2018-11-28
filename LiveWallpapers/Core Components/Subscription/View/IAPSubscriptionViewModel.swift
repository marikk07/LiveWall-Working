//
//  IAPSubscriptionViewModel.swift
//  coloringbook
//
//  Created by Alvaro Royo on 26/2/18.
//  Copyright © 2018 Tapptil. All rights reserved.
//

import UIKit
import StoreKit


func fade(view: UIImage?) {
    
}


func bounce(view: UIView?) {
    view?.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    UIView.animate(withDuration: 0.6,
                   delay: 0,
                   usingSpringWithDamping: 1.0,
                   initialSpringVelocity: 1.0,
                   options: [.allowUserInteraction, .beginFromCurrentState, .autoreverse, .repeat],
                   animations: {
                    view?.transform = .identity
    },
                   completion: nil)
    
}


protocol IAPSubscriptionViewModelProtocol : class {
    func buySubscription()
    func restoreSubscription()
}

class IAPSubscriptionViewModel: NSObject, IAPSubscriptionViewModelProtocol {

    /// View protocol reference for make view changes.
    weak var view:IAPSubscriptionViewControllerProtocol!
    
    /// Router protocol reference for navigations.
    var router:IAPSubscriptionNavigationPorotocol!
    
    func buySubscription() {
        ShopManager.sharedInstance.buySubscription()
    }
    
    func restoreSubscription() {
        ShopManager.sharedInstance.restorePurchase(id: Constants.subscriptionID) { (success) in
            if success {
                ShopManager.sharedInstance.showAlert(title: "Restored", message: "Your subscription has been restored")
                ShopManager.sharedInstance.showMainScreen()
                UserDefaults.standard.set(true, forKey: Constants.UDsubscriptionEnable)
            }else{
                ShopManager.sharedInstance.showAlert(title: "Restore", message: "You don't have a memebership to restore.")
                UserDefaults.standard.set(true, forKey: Constants.UDsubscriptionEnable)
            }
        }
}
}
    

