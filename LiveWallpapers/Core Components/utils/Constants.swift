//
//  Constants.swift
//  coloringbook
//
//  Created by Iulian Dima on 11/27/16.
//  Copyright © 2016 Tapptil. All rights reserved.
//

import UIKit

struct Constants {
    
    static var isSubscribed: Bool {
        return UserDefaults.standard.bool(forKey: UDsubscriptionEnable)
    }
    
    // In App Purchase ID for removing ads
    static let removeAdsID = "com.tapptil.test.removeads"
    
    // In App Purchase ID for subscription
    static let subscriptionID = "407080"
    
    // In App Purchase ID for Monthly subscription
    static let monthlySubscriptionID = "203040"
    
    // In App Purchase ID for Yearly subscription
    static let yearlySubscriptionID = "507080"
    
    // In App Purchase ID for Unlimited subscription
    //static let unlimitedSubscriptionID = "LiveWeekly"
    
    // Subscription key user Defaults
    static let UDsubscriptionEnable = "SubscriptionEnable"
    
    // The shared secret is a unique code to receive receipts for all your auto-renewable in-app purchases
    // The code can be found on top of the In-App Purchases list of your app in iTunesConnect
    static let sharedSecret = "fd95abe8b12442f0aef0eb9993e4b9ee"
    
    // Set this variable to false when testing in sandbox mode
    // For distribution on app store set it to true
    static let production = false
    
    // Admob app id
    static let AdMobAppId = "ca-app-pub-6303337717441954~7059777822"
    
    // Banner ad unit ID.
    static let AdMobAdUnitID = "ca-app-pub-6303337717441954/1013244225"
    
    
    // Interstial ad unit ID.
    static let AdMobInterstialID = "ca-app-pub-3940256099942544/4411468910"
    
    // Message to display when sharing the drawing
    static let defaultSharingMessage = "Check my drawing!"
    
    // Info buttons url
    static let facebookURL = "https://www.facebook.com/monumentvalleygame"
    
    static let rateAppURL = "itms-apps://itunes.apple.com/app/id728293409"
    
    static let moreAppsURL = "itms-apps://itunes.apple.com/app/id728293409"
    
    // Variables for enabling/disabling ads, packs and subscription
    static let bannerEnabled = true
    
    static let interstialEnabled = true
    
    static let packsPurchaseEnabled = false
    
    static let subscriptionEnabled = true
    
    static let freeTrialEnabled = true
    
    static let faqViewEnabled = true
    
    // Clear fill on second tap
    static let clearFill = true
    
    // Set brush settings to autohide on iPad or iPhone
    static let brushSettAutohideIpad = true
    static let brushSettAutohideIphone = true
    
    static let watermarkAlign = WatermarkAlign.right
}

enum WatermarkAlign: Int {
    case left, right
}

// -----------------------------------

typealias EmptyCompletion = () -> Void
typealias StringCompletion = (_ text: String) -> Void

extension UICollectionView {
    
    func registerSupplementaryView<T: UICollectionReusableView>(withClass name: T.Type, ofKind ViewOfKind: String) {
        register(UINib(nibName: name.nibName, bundle: nil), forSupplementaryViewOfKind: ViewOfKind, withReuseIdentifier: name.nibName)
    }
    
    func registerCell<T: UICollectionViewCell>(withClass name: T.Type) {
        register(UINib(nibName: name.nibName, bundle: nil), forCellWithReuseIdentifier: name.cellIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: name.cellIdentifier, for: indexPath) as! T
    }
    
}

extension UIView {
    
    var nibName: String {
        return String(describing: type(of: self))
    }
    
    static var nibName: String {
        return String(describing: self)
    }
    
}

// MARK: - Methods
extension UIView {
    
    public class func fromNib(_ nibNameOrNil: String? = nil) -> Self {
        return fromNib(nibNameOrNil, type: self)
    }
    
    public class func fromNib<T : UIView>(_ nibNameOrNil: String? = nil, type: T.Type) -> T {
        let v: T? = fromNib(nibNameOrNil, type: T.self)
        return v!
    }
    
    public class func fromNib<T : UIView>(_ nibNameOrNil: String? = nil, type: T.Type) -> T? {
        var view: T?
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            // Most nibs are demangled by practice, if not, just declare string explicitly
            name = nibName
        }
        let nibViews = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        for v in nibViews! {
            if let tog = v as? T {
                view = tog
            }
        }
        return view
    }
    
}

extension UICollectionViewCell {
    
    var cellIdentifier: String {
        return String(describing: type(of: self))
    }
    
    static var cellIdentifier: String {
        return String(describing: self)
    }
    
    class var cellNib: UINib {
        get {
            return UINib.init(nibName: self.cellIdentifier, bundle:nil)
        }
    }
}

extension UITableViewCell {
    
    var cellIdentifier: String {
        return String(describing: type(of: self))
    }
    
    static var cellIdentifier: String {
        return String(describing: self)
    }
    
    class var cellNib: UINib {
        get {
            return UINib.init(nibName: self.cellIdentifier, bundle:nil)
        }
    }
}


// MARK: - Methods
extension UITableView {
    
    func registerCell<T: UITableViewCell>(withClass name: T.Type) {
        register(UINib(nibName: name.nibName, bundle: nil), forCellReuseIdentifier: name.cellIdentifier)
    }
    
    func registerHeaderFooterView<T: UITableViewHeaderFooterView>(withClass name: T.Type) {
        register(UINib(nibName: name.nibName, bundle: nil), forHeaderFooterViewReuseIdentifier: name.nibName)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as! T
    }
    
}

extension UIColor {
    
    convenience init(r: Int, g: Int, b: Int, alpha: CGFloat) {
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
    }
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0x00ff0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x0000ff00) >> 8) / 255.0
        let blue = CGFloat((hex & 0x000000ff)) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
}
