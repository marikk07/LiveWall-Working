//
//  StartSegue.swift
//
//  Created by Vladyslav Gamalii on 11.08.17.
//  Copyright © 2017 Vladyslav Gamalii. All rights reserved.
//

import UIKit

final class StartSegue: UIStoryboardSegue {
    override func perform() {
//        assert((source as? StartSegueNavigating) != nil, "Source view controller must conform to TabSegueProtocol")
        if let sourceViewController = source as? StartSegueNavigating {
            sourceViewController.currentViewController = destination
        }
    }
}
