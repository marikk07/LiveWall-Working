//
//  WallpapersViewController.swift
//  LiveWallpapers
//
//  Created by Vladyslav Gamalii on 9/23/18.
//  Copyright © 2018 Codex. All rights reserved.
//

import UIKit
import ScalingCarousel

final class WallpapersViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak private var sortByDateButton: UIButton!
    @IBOutlet weak private var arrowImageView: UIImageView!
    @IBOutlet weak private var carouselButton: UIButton!
    @IBOutlet weak private var gridButton: UIButton!
    @IBOutlet weak private var gridView: GridView!
    
    @IBOutlet weak private var caroucelCollectionView: ScalingCarouselView!
    
    // MARK: - Properties
    
    var dataSource: [Wallpaper]!
    var navTitle: String?
    
    private var isSortSelected: Bool = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaroucelCollectionView()
        setupGridCollectionView()
        bindGridView()
        addBehaviors([ShowNavigationBarBehavior(), TransparentNavigationBarBehaviour()])
        self.title = navTitle
    }

    // MARK: - IBActions
    
    @IBAction func sortByDateAction(_ sender: UIButton) {
        isSortSelected = !isSortSelected
        if isSortSelected {
            dataSource.sort(by: { $0.name > $1.name })
        } else {
            dataSource.sort(by: { $0.name < $1.name })
        }
        isSortSelected ? arrowImageView.expandArrowUp(animated: true) : arrowImageView.collapseArrowDown(animated: true)
        gridView.collectionView.reloadData()
        caroucelCollectionView.reloadData()
    }
    
    @IBAction func carouselAction(_ sender: UIButton) {
        if carouselButton.isSelected {
            return
        }
        carouselButton.isSelected = !carouselButton.isSelected
        gridButton.isSelected = false
        caroucelCollectionView.isHidden = false
        gridView.isHidden = true
    }
    
    @IBAction func gridAction(_ sender: UIButton) {
        if gridButton.isSelected {
            return
        }
        gridButton.isSelected = !gridButton.isSelected
        carouselButton.isSelected = false
        caroucelCollectionView.isHidden = true
        gridView.isHidden = false
    }
    
    // MARK: - Private Methods
    
    private func setupCaroucelCollectionView() {
        caroucelCollectionView.registerCell(withClass: CaroucelCollectionViewCell.self)
        caroucelCollectionView.delegate = self
        caroucelCollectionView.dataSource = self
    }
    
    private func setupGridCollectionView() {
        gridView.collectionView.registerCell(withClass: WallpaperCollectionViewCell.self)
        gridView.collectionView.delegate = gridView
        gridView.collectionView.dataSource = self
    }
    
    private func bindGridView() {
        gridView.didSelectItem = { [weak self] (index) in
            guard let strongSelf = self else { return }
            if !Constants.isSubscribed {
                strongSelf.showSubscriptionScene(item: strongSelf.dataSource[index])
                return
            }
            strongSelf.performSegue(withIdentifier: MainViewController.storyboardIdentifier, sender: strongSelf.dataSource[index])
        }
    }
    
    private func showSubscriptionScene(item: Wallpaper) {
        let subscriptionVC: SubscriptionViewController = Storyboard.Main.instantiateViewController()
        subscriptionVC.didCompleteSubscription = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.performSegue(withIdentifier: MainViewController.storyboardIdentifier, sender: item)
        }
        present(subscriptionVC, animated: true, completion:  nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mainVC = segue.destination as? MainViewController {
            guard let selectedWallpaper = sender as? Wallpaper else { fatalError() }
            mainVC.wallpaper = selectedWallpaper
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension WallpapersViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView === caroucelCollectionView {
            caroucelCollectionView.didScroll()
        }
    }
    
    // Caroucel collection view delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if !Constants.isSubscribed {
            showSubscriptionScene(item: dataSource[indexPath.item])
            return
        }
        performSegue(withIdentifier: MainViewController.storyboardIdentifier, sender: dataSource[indexPath.item])
    }
}

// MARK: - UICollectionViewDataSource

extension WallpapersViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView === caroucelCollectionView {
            let cell = collectionView.dequeueReusableCell(withClass: CaroucelCollectionViewCell.self, for: indexPath)
            cell.wallpaperImageView.image = dataSource[indexPath.item].image
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withClass: WallpaperCollectionViewCell.self, for: indexPath)
        cell.wallpaperImageView.image = dataSource[indexPath.item].image
        return cell
    }
}
