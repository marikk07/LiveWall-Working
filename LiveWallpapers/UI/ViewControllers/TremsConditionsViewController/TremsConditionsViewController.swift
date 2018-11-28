//
//  TremsConditionsViewController.swift
//  LiveWallpapers
//
//  Created by Vladyslav Gamalii on 10/20/18.
//  Copyright © 2018 Codex. All rights reserved.
//

import UIKit

final class TremsConditionsViewController: UIViewController {

    
    // MARK: - IBOutlets
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var textVIew: UITextView!
    
    // MARK: - Properties
    
    var viewModel: TermsPrivacyType!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - IBActions
    
    @IBAction func closeAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    // MARK: - Private
    
    private func setupUI() {
        guard viewModel != nil else { return }
        titleLabel.text = viewModel.title
        textVIew.text.removeAll()
        textVIew.attributedText = viewModel.text
    }
    
}
