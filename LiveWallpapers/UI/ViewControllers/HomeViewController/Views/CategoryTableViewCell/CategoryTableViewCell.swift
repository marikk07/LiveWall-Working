//
//  CategoryTableViewCell.swift
//  LiveWallpapers
//
//  Created by Vladyslav Gamalii on 9/23/18.
//  Copyright © 2018 Codex. All rights reserved.
//

import UIKit

struct CategoryItem {
    
    var id: String?
    var color: UIColor
    var name: String
    var wallpapers: [Wallpaper]
    
    init(color: UIColor, name: String, wallpapers: [Wallpaper]) {
        self.color = color
        self.name = name
        self.wallpapers = wallpapers
    }
}

final class CategoryTableViewCell: HomeTableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
     var dataSource: [CategoryItem] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDataSource()
        setupCollectionView()
    }

    private func setupDataSource() {
        dataSource = LiveCategories.all
    }
    
    private func setupCollectionView() {
        collectionView.registerCell(withClass: CategoryItemCollectionViewCell.self)
        collectionView.contentInset = UIEdgeInsetsMake(0, 24, 0, 24)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
   
}


extension CategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.height, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        didSelectItem?(dataSource[indexPath.item].name)
    }
    
}

extension CategoryTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: CategoryItemCollectionViewCell.self, for: indexPath)
        cell.categoryNameLabel.text = dataSource[indexPath.item].name
        cell.backgroundColoredView.backgroundColor = dataSource[indexPath.item].color
        return cell
    }
}
