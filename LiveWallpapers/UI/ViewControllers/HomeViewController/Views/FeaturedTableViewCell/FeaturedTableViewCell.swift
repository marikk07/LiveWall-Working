//
//  FeaturedTableViewCell.swift
//  LiveWallpapers
//
//  Created by Vladyslav Gamalii on 9/23/18.
//  Copyright © 2018 Codex. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    var didSelectItem: StringCompletion?
}

final class FeaturedTableViewCell: HomeTableViewCell {

    @IBOutlet weak private var collectionView: UICollectionView!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDataSource()
        setupCollectionView()
    }
    
    // MARK: - Properties
    
    var dataSource: [WallpaperCellViewModel] = [WallpaperCellViewModel]()
    
    // MARK: - Private
    
    private func setupDataSource() {
        dataSource = Wallpapers.featured.map({ WallpaperCellViewModel(id: $0.name, image: $0.image) })
    }

    private func setupCollectionView() {
        collectionView.registerCell(withClass: WallpaperCollectionViewCell.self)
        collectionView.contentInset = UIEdgeInsetsMake(0, 24, 0, 24)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
   
}

extension FeaturedTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width * 0.55, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        didSelectItem?(dataSource[indexPath.item].id)
    }
    
}

extension FeaturedTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: WallpaperCollectionViewCell.self, for: indexPath)
        
        cell.wallpaperImageView.image = dataSource[indexPath.row].image
        return cell
    }
}
