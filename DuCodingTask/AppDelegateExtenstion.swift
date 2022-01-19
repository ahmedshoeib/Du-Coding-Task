//
//  AppDelegateExtenstion.swift
//  DuCodingTask
//
//  Created by Ahmed Shoeib on 8/29/19.
//  Copyright © 2019 Du. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Foundation

extension AppDelegate {
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    var rootViewController: BaseViewController {
        return window!.rootViewController as! BaseViewController
    }
    
    internal func setupApp(window: UIWindow) {
        setupKeyBoard()
        boot(window: window)
    }
    
    internal func boot(window: UIWindow) {
        let router = HomeViewRouter()
        let homeViewModel = HomeViewModel(router: router)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        homeViewController.viewModel = homeViewModel

        router.viewController = homeViewController

        window.rootViewController = UINavigationController(rootViewController: homeViewController)
    }
    
    // setup IQKeyboardManager 
    internal func setupKeyBoard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Done"
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
}
