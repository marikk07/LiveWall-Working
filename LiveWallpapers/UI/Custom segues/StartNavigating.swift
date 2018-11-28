//
//  StartNavigating.swift
//
//  Created by Vladyslav Gamalii on 11.08.17.
//  Copyright © 2017 Vladyslav Gamalii. All rights reserved.
//

import UIKit

protocol StartNavigating {
    
    var oldViewController: UIViewController? { get set }
    
    func showChildViewController(child: UIViewController)
}

extension StartNavigating where Self: UIViewController {
    
    func showChildViewController(child: UIViewController) {
        
        self.addChildViewController(child)
        child.didMove(toParentViewController: self)
        child.view.alpha = 0.0
        self.view.addSubview(child.view)
        child.view.frame = self.view.bounds
        
        UIView.animate(withDuration: 0.33, animations: {
            child.view.alpha = 1.0
        }) { [weak self] (finished) in
            guard let strongSelf = self else { return }
            if let previous = strongSelf.oldViewController {
                strongSelf.removeViewController(viewController: previous)
            }
        }
    }
    
    fileprivate func removeViewController(viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        viewController.removeFromParentViewController()
        viewController.view.removeFromSuperview()
    }
    
}
