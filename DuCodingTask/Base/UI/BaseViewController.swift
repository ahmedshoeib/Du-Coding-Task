//
//  BaseViewController.swift
//  CarWash
//
//  Created by Shoeib on 7/27/19.
//  Copyright © 2019 CarWash. All rights reserved.
//

import UIKit
import KRProgressHUD
import SwiftEntryKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    internal func showLoading(show:Bool,message:String? = nil) {
        if show {
            KRProgressHUD.show(withMessage: message ?? "Loading...")
        }else{
            KRProgressHUD.dismiss()
        }
    }
    
    internal func showError(title:String? = nil,message:String?) {

        let attributesWrapper: EntryAttributeWrapper = {
            var attributes = EKAttributes()
            attributes.positionConstraints = .float
            attributes.hapticFeedbackType = .error
            attributes.displayDuration = 4
            attributes.positionConstraints.safeArea = .empty(fillSafeArea: false)
            attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
            attributes.entryBackground = .color(color: .white)
            attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 10, offset: .zero))
            return EntryAttributeWrapper(with: attributes)
        }()
        
        let title = EKProperty.LabelContent(text: title ?? "Error", style: EKProperty.LabelStyle(font: UIFont.systemFont(ofSize: 18), color: EKColor(UIColor.appRedColor())))
        let description = EKProperty.LabelContent(text: message ?? "Someting went wrong", style: EKProperty.LabelStyle(font: UIFont.systemFont(ofSize: 18), color: EKColor(UIColor.appBlackColor())))
//        let image = EKProperty.ImageContent(image: icon ?? UIImage(named: "LockActive")!, size: CGSize(width: 36, height: 36))
        let simpleMessage = EKSimpleMessage(image: nil, title: title, description: description)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        
        let contentView = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: contentView, using: attributesWrapper.attributes)
    }

}


