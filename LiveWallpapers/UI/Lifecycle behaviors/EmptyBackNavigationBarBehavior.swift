//
//  EmptyBackNavigationBarBehavior.swift
//
//  Created by Vladyslav Gamalii on 9/8/17.
//  Copyright © 2017 Vladyslav Gamalii. All rights reserved.
//

import UIKit


struct EmptyBackNavigationBarBehavior: ViewControllerLifecycleBehavior {
 
    func afterLoading(_ viewController: UIViewController) {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backButton.tintColor = .white
        viewController.navigationItem.backBarButtonItem = backButton
    }
    
}
