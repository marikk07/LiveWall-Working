//
//  HideNavigationBarBehavior.swift
//
//  Created by Vladyslav Gamalii on 9/7/17.
//  Copyright © 2017 Vladyslav Gamalii. All rights reserved.
//

import UIKit

struct HideNavigationBarBehavior: ViewControllerLifecycleBehavior {
    
    func beforeAppearing(_ viewController: UIViewController) {
        viewController.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func beforeDisappearing(_ viewController: UIViewController) {
//        viewController.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

