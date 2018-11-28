//
//  IAPSubscriptionsViewController.swift
//  coloringbook
//
//  Created by Alvaro Royo on 26/2/18.
//  Copyright © 2018 Tapptil. All rights reserved.
//

import UIKit
import StoreKit

protocol IAPSubscriptionViewControllerProtocol : class {
    
}

class IAPSubscriptionViewController: UIViewController, IAPSubscriptionViewControllerProtocol {

    var viewModel: IAPSubscriptionViewModelProtocol!
    
    let toImage = UIImage(named:"image.png")
    
    private var lastContentOffset: CGFloat = 0
    
    @IBOutlet weak var myScroll: UIScrollView!
    
    @IBOutlet weak var subsText: UITextView!
    
    @IBOutlet weak var priceText: UILabel!
 
    @IBOutlet weak var startImage: UIImageView!
    
    @IBOutlet weak var btn: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        try? VideoBackground.shared.play(view: view, videoName: "LW37", videoType: "MOV")
        
        //Scrollable.createContentView(myScroll)
        
        ShopManager.sharedInstance.showMainScreen()
        
        self.subsText.scrollRangeToVisible(NSMakeRange(0, 0))
        
        btn.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue:255/255, alpha: 1.0 ).cgColor
        
        SwiftyStoreKit.retrieveProductsInfo([Constants.subscriptionID, Constants.monthlySubscriptionID, Constants.yearlySubscriptionID]) { result in
            if let product = result.retrievedProducts.first {
                let priceString = product.localizedPrice!
                print("Product: \(product.localizedDescription), price: \(priceString)")
                self.priceText.text = "3-day free trial, then \(priceString) per week, auto-renewing"
                self.subsText.text = "About Membership Subscription: - Subscription period is 1 year or 1 week. Every 1 year or 1 week your subscription renews. Prices for subscriptions start at \(priceString) and will be seen on the confirmation screen. Payment will be charged to iTunes Account at confirmation of purchase. Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period. Account will be charged for renewal within the 24-hours prior to the end of the selected subscription period. Subscriptions may be managed by going to the user's Account Settings after purchase. Any unused portion of a free trial period, if offered, will be forfeited when the user purchases a subscription to that publication, where applicable: Privacy Policy: http://codex.mobi/privacy-policy - Terms of Use: http://codex.mobi/terms-of-use"
            }
            else if let invalidProductId = result.invalidProductIDs.first {
                print("Invalid product identifier: \(invalidProductId)")
            }
            else {
                print("Error: \(String(describing: result.error))")
                self.priceText.text = "Data not found"
            }
        }
        
        //let numberFormatter = NumberFormatter()
        //numberFormatter.formatterBehavior = .behavior10_4
        //numberFormatter.numberStyle = .currency
        //numberFormatter.locale = viewModel.priceLocale
        //let formattedPrice = numberFormatter.string(from: viewModel.price)
        
        
        
        bounce(view: btn)
  
    }
    
    @IBAction func startTrial() {
        self.viewModel.buySubscription()
        
        
    }
    
    @IBAction func restoreAction() {
        self.viewModel.restoreSubscription()
    }
    
    @IBAction func termsAction() {
        UIApplication.shared.openURL(URL(string: "https://codex.mobi/terms-of-use")!)
    }
    
    
    //MARK: - View Delegate
}
