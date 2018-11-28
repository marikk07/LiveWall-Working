//
//  UIView+FadeTransition.swift
//  LiveWallpapers
//
//  Created by Vladyslav Gamalii on 11/12/18.
//  Copyright © 2018 Codex. All rights reserved.
//

import UIKit


extension UIView {
    
    func fadeTransition(_ duration: CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade
        animation.duration = duration
        layer.add(animation, forKey: "fade")
    }
}
