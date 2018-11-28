//
//  GridView.swift
//  LiveWallpapers
//
//  Created by Vladyslav Gamalii on 9/23/18.
//  Copyright © 2018 Codex. All rights reserved.
//

import UIKit

typealias IntCompletion = (_ index: Int) -> Void

final class GridView: UIView {

     @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var didSelectItem: IntCompletion?
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: - Private Methods
    
    
    private func commonInit() {
        Bundle.main.loadNibNamed(self.nibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.backgroundColor = .clear
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension GridView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSpacing: CGFloat = 20 / 3
        let collectionViewWidth = collectionView.bounds.width
        let collectionHeight = collectionView.bounds.height
        
        let cellHeight = (collectionHeight / 3) - cellSpacing
        let cellWidth = (collectionViewWidth / 3) - cellSpacing
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        didSelectItem?(indexPath.item)
    }
}
