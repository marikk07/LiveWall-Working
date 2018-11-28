//
//  UINavigationBar+.swift
//  coloringbook
//
//  Created by Iulian Dima on 3/6/17.
//  Copyright © 2017 Tapptil. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    public func applyShadow() {
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.3
    }
}

