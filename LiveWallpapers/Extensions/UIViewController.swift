//
//  UIViewController.swift
//
//  Created by Vladyslav Gamalii on 11.08.17.
//  Copyright © 2017 Vladyslav Gamalii. All rights reserved.
//

import UIKit
import AVKit

// MARK: - Properties
extension UIViewController {
    
    var isVisible: Bool {
        return self.isViewLoaded && view.window != nil
    }
    
    var navBar: UINavigationBar? {
        return navigationController?.navigationBar
    }
    
    var storyboardIdentifier: String {
        return String(describing: type(of: self))
    }
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
}

// MARK: - Methods
extension UIViewController {
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }

    func popToRootViewController() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func addNotificationObserver(name: Notification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }
    
    func removeNotificationObserver(name: Notification.Name) {
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
    }
    
    func removeNotificationsObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func playVideo(at url: URL) {
        let moviePlayer = AVPlayerViewController()
        moviePlayer.player = AVPlayer(url: url)
        present(moviePlayer, animated: true, completion: nil)
    }
    
}

// MARK: - Hide keyboard on swipe or tap UIViewController category
extension UIViewController {
    
    func addKeyboardNotifications() {
        self.addNotificationObserver(name: .UIKeyboardWillShow, selector: #selector(keyboardWillShow))
        self.addNotificationObserver(name: .UIKeyboardWillHide, selector: #selector(keyboardWillHide))
    }
    
    func removeKeyboardNotifications() {
        self.removeNotificationObserver(name: .UIKeyboardWillShow)
        self.removeNotificationObserver(name: .UIKeyboardWillHide)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func hideKeyboardWhenSwipeDown() {
        let swipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        swipe.direction = .down
        swipe.cancelsTouchesInView = false
        view.addGestureRecognizer(swipe)
    }
    
    // MARK: - Private Methods
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        if self.presentedViewController == nil, self.isVisible {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0 - (keyboardSize.height / 2), width: self.view.frame.width, height: self.view.frame.height)
                }, completion: { (completed) in
                    
                })
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        if self.presentedViewController == nil, self.isVisible {
            UIView.animate(withDuration: 0.3, animations: {
                self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            }, completion: { (completed) in
                
            })
        }
    }
}


// MARK: - ViewControllerLifecycleBehavior

extension UIViewController {
    /*
     Add behaviors to be hooked into this view controller’s lifecycle.
     
     This method requires the view controller’s view to be loaded, so it’s best to call
     in `viewDidLoad` to avoid it being loaded prematurely.
     
     - parameter behaviors: Behaviors to be added.
     */
    func addBehaviors(_ behaviors: [ViewControllerLifecycleBehavior]) {
        let behaviorViewController = LifecycleBehaviorViewController(behaviors: behaviors)
        
        addChildViewController(behaviorViewController)
        view.addSubview(behaviorViewController.view)
        behaviorViewController.didMove(toParentViewController: self)
    }
    
    private final class LifecycleBehaviorViewController: UIViewController {
        private let behaviors: [ViewControllerLifecycleBehavior]
        
        // MARK: - Initialization
        
        init(behaviors: [ViewControllerLifecycleBehavior]) {
            self.behaviors = behaviors
            
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - UIViewController
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.isHidden = true
            
            applyBehaviors { behavior, viewController in
                behavior.afterLoading(viewController)
            }
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            applyBehaviors { behavior, viewController in
                behavior.beforeAppearing(viewController)
            }
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            applyBehaviors { behavior, viewController in
                behavior.afterAppearing(viewController)
            }
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            applyBehaviors { behavior, viewController in
                behavior.beforeDisappearing(viewController)
            }
        }
        
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            
            applyBehaviors { behavior, viewController in
                behavior.afterDisappearing(viewController)
            }
        }
        
        override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()
            
            applyBehaviors { behavior, viewController in
                behavior.beforeLayingOutSubviews(viewController)
            }
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
            applyBehaviors { behavior, viewController in
                behavior.afterLayingOutSubviews(viewController)
            }
        }
        
        // MARK: - Private
        
        private func applyBehaviors(body: (_ behavior: ViewControllerLifecycleBehavior, _ viewController: UIViewController) -> Void) {
            guard let parentViewController = parent else { return }
            
            for behavior in behaviors {
                body(behavior, parentViewController)
            }
        }
    }
}

