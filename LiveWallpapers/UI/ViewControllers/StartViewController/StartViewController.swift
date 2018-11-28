//
//  StartViewController.swift
//  LiveWallpapers
//
//  Created by Vladyslav Gamalii on 9/19/18.
//  Copyright © 2018 Codex. All rights reserved.
//

import UIKit

final class StartViewController: UIViewController {
    
    @IBOutlet weak private var startTrialButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - IBActions
    
    @IBAction func startTrialAction(_ sender: UIButton) {
        let vc: SubscriptionViewController = Storyboard.Main.instantiateViewController()
        vc.didCompleteSubscription = { [weak self] in
            self?.performSegue(withIdentifier: HomeViewController.storyboardIdentifier, sender: nil)
        }
        present(vc, animated: true, completion:  nil)
    }
    
    @IBAction func skipToAppAction(_ sender: UIButton) {
        performSegue(withIdentifier: HomeViewController.storyboardIdentifier, sender: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? SubscriptionViewController {
            destinationVC.didCompleteSubscription = { [weak self] in
                self?.performSegue(withIdentifier: HomeViewController.storyboardIdentifier, sender: nil)
            }
        }
    }
}
