//
//  TransparentNavigationBarBehaviour.swift
//
//  Created by Vladyslav Gamalii on 9/8/17.
//  Copyright © 2017 Vladyslav Gamalii. All rights reserved.
//

import UIKit

struct TransparentNavigationBarBehaviour: ViewControllerLifecycleBehavior {
    
    var navigationTitle: String
    var hideBarWhenScroll: Bool
    
    init(navTitle: String = "", hideBarWhenScroll: Bool = false) {
        self.navigationTitle = navTitle
        self.hideBarWhenScroll = hideBarWhenScroll
    }
    
    func afterLoading(_ viewController: UIViewController) {
        viewController.navigationItem.title = navigationTitle
        viewController.navBar?.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font : UIFont.systemFont(ofSize: 20)]
    }
    
    func beforeAppearing(_ viewController: UIViewController) {
        viewController.navBar?.isTranslucent = true
        viewController.navBar?.barTintColor = .white
        viewController.navigationController?.hidesBarsOnSwipe = hideBarWhenScroll
        viewController.navBar?.setBackgroundImage(UIImage(), for: .default)
        viewController.navBar?.shadowImage = UIImage()
    }
    
    func beforeDisappearing(_ viewController: UIViewController) {
        viewController.navigationController?.hidesBarsOnSwipe = hideBarWhenScroll
    }
    
    
}
