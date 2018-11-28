//
//  ShowNavigationBarBehavior.swift
//
//  Created by Vladyslav Gamalii on 9/8/17.
//  Copyright © 2017 Vladyslav Gamalii. All rights reserved.
//

import UIKit

struct ShowNavigationBarBehavior: ViewControllerLifecycleBehavior {
    
    var animated: Bool

    init(animated: Bool = false) {
        self.animated = animated
    }
    
    func beforeAppearing(_ viewController: UIViewController) {
        viewController.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func beforeDisappearing(_ viewController: UIViewController) {
//        viewController.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
}
