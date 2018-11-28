//
//  UIImageView.swift
//  LiveWallpapers
//
//  Created by Vladyslav Gamalii on 10/25/18.
//  Copyright © 2018 Codex. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func collapseArrowDown(animated: Bool) {
        UIView.animate(withDuration: (animated ? 0.3 : 0)) { [weak self] in
            self?.transform = CGAffineTransform(rotationAngle: (CGFloat.pi * -360/180))
        }
    }
    
    func expandArrowUp(animated: Bool) {
        UIView.animate(withDuration: (animated ? 0.3 : 0)) { [weak self] in
            self?.transform = CGAffineTransform(rotationAngle: (CGFloat.pi))
        }
    }
    
}
