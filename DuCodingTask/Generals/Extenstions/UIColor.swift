//
//  UIColor.swift
//  CarWash
//
//  Created by Shoeib on 7/27/19.
//  Copyright © 2019 CarWash. All rights reserved.
//

import UIKit


extension UIColor {

    class func appRedColor() -> UIColor { return #colorLiteral(red: 0.8549019608, green: 0.1254901961, blue: 0.1960784314, alpha: 1) }
    
    class func appBlackColor() -> UIColor { return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) }


    convenience init(hex: String, alpha: CGFloat?) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        var finalAlpha: CGFloat = 0
        if let alphaParam = alpha {
            finalAlpha = alphaParam
            
        } else {
            finalAlpha = CGFloat(a) / 255
        }
        
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: finalAlpha)
    }
}
