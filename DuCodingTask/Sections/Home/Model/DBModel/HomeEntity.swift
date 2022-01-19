//
//  HomeDBModel.swift
//  DuCodingTask
//
//  Created by Ahmed Shoeib on 8/31/19.
//  Copyright © 2019 Du. All rights reserved.
//

import Foundation
import CoreData


@objc(HomeEntity)
extension HomeEntity  {
    
    convenience init (createdDate: Int64,externalLink: String?,externalLinkArabic: String?,imagePath: String?,isActive: Bool,isCmsApi: Bool,isCmsSection: Bool,isDeletable: Bool,isLink: Bool,isTileView: Bool,isVisible: Bool,position: Int64,sectionId: Int64,shortDesc: String?,shortDescArabic: String?,shortDescColor: String?,title: String?,titleArabic: String?,titleColor: String?,updatedDate: Int64, entity: NSEntityDescription, context: NSManagedObjectContext!) {
        
        
        self.init(entity: entity, insertInto: context)
        
        self.createdDate = createdDate
        self.externalLink = externalLink
        self.externalLinkArabic = externalLinkArabic
        self.imagePath = imagePath
        self.isActive = isActive
        self.isCmsApi = isCmsApi
        self.isCmsSection = isCmsSection
        self.isDeletable = isDeletable
        self.isLink = isLink
        self.isTileView = isTileView
        self.isVisible = isVisible
        self.position = position
        self.sectionId = sectionId
        self.shortDesc = shortDesc
        self.shortDescArabic = shortDescArabic
        self.shortDescColor = shortDescColor
        self.title = title
        self.titleArabic = titleArabic
        self.titleColor = titleColor
        self.updatedDate = updatedDate
        
    }
}
