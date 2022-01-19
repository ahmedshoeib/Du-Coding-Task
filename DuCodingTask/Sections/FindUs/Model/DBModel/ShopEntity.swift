//
//  ShopEntity+CoreDataClass.swift
//  
//
//  Created by Ahmed Shoeib on 8/31/19.
//
//

import Foundation
import CoreData

@objc(ShopEntity)
extension ShopEntity {
    
    convenience init(address: String?,addressArabic: String?,createdDate: Int64,hourOperation: String?,isActive: Bool,latitude: Double,locationId: Int64,locationSection: Int64,longitude: Double,title: String?,titleArabic: String?,updatedDate: Int64, entity: NSEntityDescription, context: NSManagedObjectContext!) {
        
        
        self.init(entity: entity, insertInto: context)
        
        self.address = address
        self.addressArabic = addressArabic
        self.createdDate = createdDate
        self.hourOperation = hourOperation
        self.isActive = isActive
        self.latitude = latitude
        self.locationId = locationId
        self.locationSection = locationSection
        self.longitude = longitude
        self.title = title
        self.titleArabic = titleArabic
        self.updatedDate = updatedDate
    }
}
