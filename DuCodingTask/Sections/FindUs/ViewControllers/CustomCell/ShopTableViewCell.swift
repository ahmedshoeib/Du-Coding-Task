//
//  ShopTableViewCell.swift
//  DuCodingTask
//
//  Created by Ahmed Shoeib on 8/30/19.
//  Copyright © 2019 Du. All rights reserved.
//

import UIKit

class ShopTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var locartionLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    
    
    var data:NearestShopPayLoad? {
        didSet {
            if let payload = data {
                
                // set title text and color
                titleLbl.text = payload.title ?? ""
                locartionLbl.text = payload.address ?? ""
                distanceLbl.text = payload.distance ?? ""
            }
        }
    }
    
}
