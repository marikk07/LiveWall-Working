//
//  IAPSubscriptionRouter.swift
//  coloringbook
//
//  Created by Alvaro Royo on 26/2/18.
//  Copyright © 2018 Tapptil. All rights reserved.
//

import UIKit

protocol IAPSubscriptionNavigationPorotocol : class {
    
}

class IAPSubscriptionRouter: NSObject, IAPSubscriptionNavigationPorotocol {
    
    weak var viewController: IAPSubscriptionViewController!
    
    //MARK: - Navigation
    
    //MARK: - Class functions
    
    class func getViewController() -> IAPSubscriptionViewController {
        
        let viewController = IAPSubscriptionViewController()
        let router = IAPSubscriptionRouter()
        let viewModel = IAPSubscriptionViewModel()
        
        IAPSubscriptionRouter.configureModule(viewController, router, viewModel)
        
        return viewController
        
    }
    
    class func configureModule(_ viewController:IAPSubscriptionViewController,_ router:IAPSubscriptionRouter,_ viewModel:IAPSubscriptionViewModel ) {
        
        router.viewController = viewController
        
        viewController.viewModel = viewModel
        
        viewModel.router = router
        viewModel.view = viewController
        
    }
    
}
