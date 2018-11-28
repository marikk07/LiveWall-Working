//
//  HomeSectionHeader.swift
//  LiveWallpapers
//
//  Created by Vladyslav Gamalii on 9/23/18.
//  Copyright © 2018 Codex. All rights reserved.
//

import UIKit

final class HomeSectionHeader: UITableViewHeaderFooterView {
    
    // MARK: - IBActions
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    // MARK: - Properties
    
    var didPressMore: EmptyCompletion?
    
    // MARK: - IBActions
    
    @IBAction func moreAction(_ sender: UIButton) {
        didPressMore?()
    }
    
}
