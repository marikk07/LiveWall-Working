//
//  NewWallpapersTableViewCell.swift
//  LiveWallpapers
//
//  Created by Vladyslav Gamalii on 9/23/18.
//  Copyright © 2018 Codex. All rights reserved.
//

import UIKit

final class NewWallpapersTableViewCell: HomeTableViewCell {
    
    @IBOutlet weak private var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDataSource()
        setupCollectionView()
    }
    
    var dataSource: [WallpaperCellViewModel] = [WallpaperCellViewModel]()
    
    // MARK: - Private
    
    private func setupDataSource() {
        let allWallpapers = Array(Wallpapers.all.reversed())
        while dataSource.count < 9 {
            let idx = dataSource.count
            let item = allWallpapers[idx]
            let viewModel = WallpaperCellViewModel.init(id: item.name, image: item.image)
            dataSource.append(viewModel)
        }
    }
    
    private func setupCollectionView() {
        collectionView.registerCell(withClass: WallpaperCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

extension NewWallpapersTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
        didSelectItem?(dataSource[indexPath.item].id)
    }
    
}

extension NewWallpapersTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: WallpaperCollectionViewCell.self, for: indexPath)
        cell.wallpaperImageView.image = dataSource[indexPath.item].image
        return cell
    }
}

