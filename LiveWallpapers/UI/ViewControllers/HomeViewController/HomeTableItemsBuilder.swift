//
//  HomeTableItemsBuilder.swift
//  LiveWallpapers
//
//  Created by Vladyslav Gamalii on 9/23/18.
//  Copyright © 2018 Codex. All rights reserved.
//

import UIKit

enum HomeSectionItem: Int {
    case featured = 0
    case category = 1
    case new = 2
    
    var headerTitle: String {
        switch self {
        case .featured:
            return "Featured Wallpapers"
        case .category:
            return "Category"
        case .new:
            return "New Wallpapers"
        }
    }
    
    var cellType: HomeTableViewCell.Type {
        switch self {
        case .featured:
            return FeaturedTableViewCell.self
        case .category:
            return CategoryTableViewCell.self
        case .new:
            return NewWallpapersTableViewCell.self
        }
    }
    
}

struct HomeCellViewModel {
    var section: HomeSectionItem
    var isMoreAvailable: Bool
}


final class HomeTableItemsBuilder: NSObject {
    
    // MARK: - Public Properties
    
    var didSelectMoreCategories: EmptyCompletion?
    var didSelectMoreNew: EmptyCompletion?
    
    var didSelectCategoryName: StringCompletion?
    var didSelectWallpaper: StringCompletion?
    
    // MARK: - Private Properties
    
    weak private var tableView: UITableView!
    private var dataSource: [HomeCellViewModel] = [HomeCellViewModel]()
    
    // MARK; - Initializers
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        setupDataSource()
        setupTableView()
    }
    
    // MARK: - Private Methods
    
    private func setupDataSource() {
        let featured = HomeCellViewModel(section: .featured, isMoreAvailable: false)
        let categories = HomeCellViewModel(section: .category, isMoreAvailable: true)
        let new = HomeCellViewModel(section: .new, isMoreAvailable: true)
        dataSource = [featured, categories, new]
    }
    
    private func setupTableView() {
        tableView.registerCell(withClass: FeaturedTableViewCell.self)
        tableView.registerCell(withClass: CategoryTableViewCell.self)
        tableView.registerCell(withClass: NewWallpapersTableViewCell.self)
        tableView.registerHeaderFooterView(withClass: HomeSectionHeader.self)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = TermsConditionsFooterView.fromNib()
    }
    
}

// MARK: - UITableViewDelegate

extension HomeTableItemsBuilder: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UIScreen.main.bounds.height * 0.4
        case 1:
            return UIScreen.main.bounds.height * 0.09
        case 2:
            return (UIScreen.main.bounds.height * 0.2) * 3
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeSectionHeader.nibName) as? HomeSectionHeader
        header?.titleLabel.text = dataSource[section].section.headerTitle
        header?.moreButton.isHidden = !dataSource[section].isMoreAvailable
        header?.didPressMore = { [weak self] in
            guard let strongSelf = self else { return }
            if strongSelf.dataSource[section].section == HomeSectionItem.category {
                strongSelf.didSelectMoreCategories?()
            } else if strongSelf.dataSource[section].section == HomeSectionItem.new {
                strongSelf.didSelectMoreNew?()
            }
        }
        return header
    }
    
}

// MARK: - UITableViewDataSource

extension HomeTableItemsBuilder: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = dataSource[indexPath.section].section.cellType
        let cell = tableView.dequeueReusableCell(withClass: cellType, for: indexPath)
        cell.didSelectItem = { [weak self] (id) in
            guard let strongSelf = self else { return }
            if cellType == CategoryTableViewCell.self {
                strongSelf.didSelectCategoryName?(id)
                return
            }
            strongSelf.didSelectWallpaper?(id)
        }
        
        return cell
    }
    
}
