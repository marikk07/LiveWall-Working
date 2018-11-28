//
//  CategoriesViewController.swift
//  LiveWallpapers
//
//  Created by Vladyslav Gamalii on 9/23/18.
//  Copyright © 2018 Codex. All rights reserved.
//

import UIKit

final class CategoriesViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak private var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    var dataSource: [CategoryItem] = LiveCategories.all
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBehaviors([ShowNavigationBarBehavior(), EmptyBackNavigationBarBehavior(), TransparentNavigationBarBehaviour.init(navTitle: "Category")])
        setupCollectionView()
    }

    // MARK: - Private Methods
    
    private func setupCollectionView() {
        collectionView.registerCell(withClass: CategoryItemCollectionViewCell.self)
        collectionView.contentInset = UIEdgeInsetsMake(16, 0, 16, 0)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let wallpapersVS = segue.destination as? WallpapersViewController {
            guard let wallpapers = sender as? [Wallpaper] else { fatalError() }
            wallpapersVS.dataSource = wallpapers
            wallpapersVS.navTitle = "Grid"
        }
    }
    
}



extension CategoriesViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSpacing: CGFloat = 48 / 3
        let collectionViewWidth = collectionView.bounds.width
        let collectionHeight = collectionView.bounds.width
        
        let cellWidth = (collectionViewWidth / 3) - cellSpacing
        let cellHeight = cellWidth
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        performSegue(withIdentifier: WallpapersViewController.storyboardIdentifier, sender: dataSource[indexPath.row].wallpapers)
    }
    
}

extension CategoriesViewController: UICollectionViewDataSource {
    
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



