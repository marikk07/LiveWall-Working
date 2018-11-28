//
//  Storyboard.swift
//
//  Created by Vladyslav Gamalii on 3/27/18.
//  Copyright © 2018 NerdPeople. All rights reserved.
//

import UIKit

enum Storyboard: String {
    case Main
    
    // MARK: - Private Properties
    
    private var storyboard: UIStoryboard {
        let bundle = Bundle.main
        let name = self.rawValue
        return UIStoryboard(name: name, bundle: bundle)
    }
    
    // MARK: - Public Methods
    
    func instantiateInitialViewController() -> UIViewController? {
        return storyboard.instantiateInitialViewController()
    }
    
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = storyboard.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier)) ")
        }
        return viewController
    }
    
    // MARK: - Private Methods
    
    private func instantiateViewController(withIdentifier identifier: String) -> UIViewController {
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}
