//
//  LiveCategories.swift
//  LiveWallpapers
//
//  Created by Vladyslav Gamalii on 9/23/18.
//  Copyright © 2018 Codex. All rights reserved.
//

import Foundation

final class LiveCategories {
    
    static let all = [CategoryItem.init(color: UIColor(r: 65, g: 173, b: 241, alpha: 1), name: "All", wallpapers: Wallpapers.all),
                                CategoryItem.init(color: UIColor(r: 126, g: 87, b: 194, alpha: 1), name: "Featured", wallpapers: Wallpapers.featured),
                                CategoryItem.init(color: UIColor(r: 240, g: 98, b: 148, alpha: 1), name: "Popular", wallpapers: Wallpapers.popular),
                                CategoryItem.init(color: UIColor(r: 255, g: 82, b: 82, alpha: 1), name: "Abstract", wallpapers: Wallpapers.abstract),
                                CategoryItem.init(color: UIColor(r: 209, g: 118, b: 90, alpha: 1), name: "Special", wallpapers: Wallpapers.special),
                                CategoryItem.init(color: UIColor(r: 239, g: 108, b: 0, alpha: 1), name: "Space", wallpapers: Wallpapers.space),
                                CategoryItem.init(color: UIColor(r: 255, g: 143, b: 0, alpha: 1), name: "Shapes", wallpapers: Wallpapers.shapes),
                                CategoryItem.init(color: UIColor(r: 251, g: 192, b: 45, alpha: 1), name: "Sci-Fi", wallpapers: Wallpapers.sciFi),
                                CategoryItem.init(color: UIColor(r: 128, g: 181, b: 81, alpha: 1), name: "Footage", wallpapers: Wallpapers.footage)]
    
}
