//
//  ViewControllerLifecycleBehavior.swift
//
//  Created by Vladyslav Gamalii on 9/7/17.
//  Copyright © 2017 Vladyslav Gamalii. All rights reserved.
//

import UIKit

protocol ViewControllerLifecycleBehavior {
    func afterLoading(_ viewController: UIViewController)
    func beforeAppearing(_ viewController: UIViewController)
    func afterAppearing(_ viewController: UIViewController)
    func beforeDisappearing(_ viewController: UIViewController)
    func afterDisappearing(_ viewController: UIViewController)
    func beforeLayingOutSubviews(_ viewController: UIViewController)
    func afterLayingOutSubviews(_ viewController: UIViewController)
}

extension ViewControllerLifecycleBehavior {
    func afterLoading(_ viewController: UIViewController) {}
    func beforeAppearing(_ viewController: UIViewController) {}
    func afterAppearing(_ viewController: UIViewController) {}
    func beforeDisappearing(_ viewController: UIViewController) {}
    func afterDisappearing(_ viewController: UIViewController) {}
    func beforeLayingOutSubviews(_ viewController: UIViewController) {}
    func afterLayingOutSubviews(_ viewController: UIViewController) {}
}
