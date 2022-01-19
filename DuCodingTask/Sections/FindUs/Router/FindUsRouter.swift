//
//  FindUsRouter.swift
//  DuCodingTask
//
//  Created by Ahmed Shoeib on 8/30/19.
//  Copyright © 2019 Du. All rights reserved.
//

import CoreLocation
import Foundation
import UIKit
import MapKit

class FindUsRouter: BaseRouter {
    
    enum FindUsViewRouteType : RouteType {
        case route(Double?, Double?, Double?, Double?, String?)
    }
    
    weak var viewController: UIViewController?
    
    func pushViewControllerWithtype(screenType: RouteType) {
        
        guard let routeType = screenType as? FindUsViewRouteType else {
            assertionFailure("The route type missmatches")
            return
        }
        
        switch routeType {
        case .route(let fromLat,let fromLng,let toLat,let toLng,let title):
            self.openMapWithDirection(fromLat: fromLat, fromLng: fromLng, toLat: toLat, toLng: toLng, title: title)
        }
        
    }
    
    private func openMapWithDirection(fromLat:Double?, fromLng:Double?, toLat:Double?, toLng:Double?, title:String?){
        
        if let currentLat = fromLat , let currentLng = fromLng,let lat = toLat , let lng = toLng {
            
            if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps-x-callback://")!) {
                let googleMapUrlString = "http://maps.google.com/?saddr=\(currentLat),\(currentLng)&daddr=\(lat),\(lng)"
                
                if let url = URL(string: googleMapUrlString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            } else {
                
                let coordinate = CLLocationCoordinate2DMake(lat, lng)
                let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
                mapItem.name = title ?? ""
                
                
                let currentLocationMapItemCoordinate = CLLocationCoordinate2DMake(currentLat, currentLng)
                let currentLocationMapItem = MKMapItem(placemark: MKPlacemark(coordinate: currentLocationMapItemCoordinate, addressDictionary: nil))
                currentLocationMapItem.name = "Current Location"
                
                MKMapItem.openMaps(with:[currentLocationMapItem, mapItem] , launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
            }
        }
    }
}
