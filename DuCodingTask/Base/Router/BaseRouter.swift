//
//  BaseRouter.swift
//  DuCodingTask
//
//  Created by Ahmed Shoeib on 8/31/19.
//  Copyright © 2019 Du. All rights reserved.
//

import UIKit


protocol RouteType {
}

protocol BaseRouter {
    
    var viewController: UIViewController? { get set }
    
    func pushViewControllerWithtype(screenType:RouteType);
}

