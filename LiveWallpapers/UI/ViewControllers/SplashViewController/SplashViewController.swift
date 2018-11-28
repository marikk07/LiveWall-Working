//
//  SplashViewController.swift
//  LiveWallpapers
//
//  Created by Vladyslav Gamalii on 11/15/18.
//  Copyright © 2018 Codex. All rights reserved.
//

import UIKit

final class SplashViewController: UIViewController, StartSegueNavigating, StartNavigating {
    
    // MARK: - StartNavigating
    
    var oldViewController: UIViewController?
    var currentViewController: UIViewController?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ShopManager.sharedInstance.completeTransactions()
//        ShopManager.sharedInstance.verifySubscription()
        
        showStartScreen()
    }
    
    // MARK: - Methods
    
    func showHomeScreen() {
        performSegue(withIdentifier: HomeViewController.storyboardIdentifier, sender: self)
        if let currentViewController = currentViewController {
            showChildViewController(child: currentViewController)
        }
    }
    
    func showStartScreen() {
        performSegue(withIdentifier: StartViewController.storyboardIdentifier, sender: self)
        if let currentViewController = currentViewController {
            showChildViewController(child: currentViewController)
        }
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let current = self.currentViewController {
            oldViewController = current
        }
    }

}
