//
//  HomeViewController.swift
//  LiveWallpapers
//
//  Created by Vladyslav Gamalii on 9/23/18.
//  Copyright © 2018 Codex. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            itemsBuilder = HomeTableItemsBuilder(tableView: tableView)
        }
    }
    
    @IBOutlet weak var redView: UIView! {
        didSet {
            redView.layer.cornerRadius = redView.bounds.width / 2
        }
    }
    // MARK: - Properties
    
    private var itemsBuilder: HomeTableItemsBuilder!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindItemsBuilder()
        addBehaviors([HideNavigationBarBehavior(), EmptyBackNavigationBarBehavior()])
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    // MARK: - IBActions
    
    @IBAction func lightBulbAction(_ sender: UIButton) {
        performSegue(withIdentifier: SubscriptionViewController.storyboardIdentifier, sender: nil)
    }
    
    @IBAction func infoAction(_ sender: UIButton) {
        // handle info
    }
    
    // MARK: - Private Methods
    
    private func bindItemsBuilder() {
        itemsBuilder.didSelectMoreCategories = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.performSegue(withIdentifier: CategoriesViewController.storyboardIdentifier, sender: nil)
        }
        
        itemsBuilder.didSelectMoreNew = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.performSegue(withIdentifier: WallpapersViewController.storyboardIdentifier, sender: Wallpapers.all)
        }
        itemsBuilder.didSelectCategoryName = { [weak self] (categoryName) in
            self?.showWallpapersBy(categoryName: categoryName)
        }
        itemsBuilder.didSelectWallpaper = { [weak self] (wallpaperID) in
            self?.showWallpaper(wallpaperID: wallpaperID)
        }
    }
    
    private func showWallpaper(wallpaperID: String) {
        if let index = Wallpapers.all.index(where: { $0.name == wallpaperID }) {
            let selectedWallpaper = Wallpapers.all[index]
            if !Constants.isSubscribed {
                showSubscriptionScene(item: selectedWallpaper)
                return
            }
            performSegue(withIdentifier: MainViewController.storyboardIdentifier, sender: selectedWallpaper)
        }
    }
    
    private func showWallpapersBy(categoryName: String) {
        if let categoryWallpapers = LiveCategories.all.first(where: { $0.name == categoryName })?.wallpapers {
            performSegue(withIdentifier: WallpapersViewController.storyboardIdentifier, sender: categoryWallpapers)
        }
    }
    
    // FIXME: Refactor. Duplicated method from WallpapersViewController
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
        if let _ = segue.destination as? CategoriesViewController {

        } else if let wallpapersVS = segue.destination as? WallpapersViewController {
            guard let wallpapers = sender as? [Wallpaper] else { fatalError() }
            wallpapersVS.dataSource = wallpapers
            wallpapersVS.navTitle = "Grid"
        } else if let mainVC = segue.destination as? MainViewController {
            guard let selectedWallpaper = sender as? Wallpaper else { fatalError() }
            mainVC.wallpaper = selectedWallpaper
        }
    }
    
}
