//
//  ShopAnnotattion.swift
//  DuCodingTask
//
//  Created by Ahmed Shoeib on 8/30/19.
//  Copyright © 2019 Du. All rights reserved.
//

import MapKit

class ShopAnnotation: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
