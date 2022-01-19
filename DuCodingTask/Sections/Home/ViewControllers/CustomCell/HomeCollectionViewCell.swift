//
//  HomeCollectionViewCell.swift
//  DuCodingTask
//
//  Created by Ahmed Shoeib on 8/29/19.
//  Copyright © 2019 Du. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var placeHolderImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var shortDescriptionLbl: UILabel!
    
    var data:HomePayLoad? {
        didSet {
            if let payload = data {
                
                // load the image
                if let imageUrl = payload.imagePath,imageUrl.count > 0 {
                    placeHolderImg.downloadImageFrom(link: imageUrl, contentMode: .scaleAspectFill)
                }
                
                // set title text and color
                titleLbl.text = payload.title ?? ""
                titleLbl.textColor = UIColor(hex: payload.titleColor ?? "#000000", alpha: 1)
                
                // set shortdescription and color
                shortDescriptionLbl.text = payload.shortDesc ?? ""
                shortDescriptionLbl.textColor = UIColor(hex: payload.shortDescColor ?? "#000000", alpha: 1)

            }
        }
    }
}
