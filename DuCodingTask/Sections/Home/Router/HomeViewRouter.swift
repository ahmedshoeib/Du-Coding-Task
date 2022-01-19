//
//  HomeViewRouter.swift
//  DuCodingTask
//
//  Created by Ahmed Shoeib on 8/29/19.
//  Copyright © 2019 Du. All rights reserved.
//

import UIKit

class HomeViewRouter : BaseRouter {
    
    enum HomeViewRouteType : RouteType {
        case detailsWebViewController(String)
        case findUsViewController(HomePayLoad)
    }
    
    weak var viewController: UIViewController?
    
    func pushViewControllerWithtype(screenType: RouteType) {
        
        guard let routeType = screenType as? HomeViewRouteType else {
            assertionFailure("The route type missmatches")
            return
        }
        
        guard let viewController = viewController else {
            assertionFailure("baseViewController is not set")
            return
        }
        
        switch routeType {
        case .detailsWebViewController(let url):
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let detailsWebViewController = storyboard.instantiateViewController(withIdentifier: "DetailsWebViewController") as! DetailsWebViewController
            detailsWebViewController.urlString = url
            viewController.navigationController?.pushViewController(detailsWebViewController, animated: true)
            
        case .findUsViewController(let homePayLoad) :
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let findUsViewController = storyboard.instantiateViewController(withIdentifier: "FindUsViewController") as! FindUsViewController
            findUsViewController.viewModel = FindUsViewModel(router: FindUsRouter())
            findUsViewController.homePayLoad = homePayLoad
            
            viewController.navigationController?.pushViewController(findUsViewController, animated: true)
            
        }
    }
}
