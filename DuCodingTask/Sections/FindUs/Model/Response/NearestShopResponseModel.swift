//
//  NearestShopResponseModel.swift
//  DuCodingTask
//
//  Created by Ahmed Shoeib on 8/30/19.
//  Copyright © 2019 Du. All rights reserved.
//

import UIKit

class NearestShopResponseModel: BaseResponseModel {
    let payLoad: [NearestShopPayLoad]?
    
    private enum CodingKeys: String, CodingKey {
        case nearestShopPayLoad = "payLoad"
    }
    
    init(response: Response?, payLoad: [NearestShopPayLoad]?) {
        self.payLoad = payLoad
        super.init(response: response)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let elements = try container.decode([FailableDecodable<NearestShopPayLoad>].self, forKey: .nearestShopPayLoad)
        self.payLoad = elements.compactMap { $0.base }
        try super.init(from: decoder)
    }
}

// MARK: - PayLoad
class NearestShopPayLoad : Codable {
    let locationId, locationSection: Int?
    let title, titleArabic, hourOperation, address: String?
    let addressArabic: String?
    let latitude, longitude: Double?
    let isActive, createdDate, updatedDate: Int?
    
    var distance:String?
    
    enum CodingKeys: String, CodingKey {
        case locationId
        case locationSection, title, titleArabic, hourOperation, address, addressArabic, latitude, longitude, isActive, createdDate, updatedDate
    }
    
    init(locationId: Int?, locationSection: Int?, title: String?, titleArabic: String?, hourOperation: String?, address: String?, addressArabic: String?, latitude: Double?, longitude: Double?, isActive: Int?, createdDate: Int?, updatedDate: Int?) {
        self.locationId = locationId
        self.locationSection = locationSection
        self.title = title
        self.titleArabic = titleArabic
        self.hourOperation = hourOperation
        self.address = address
        self.addressArabic = addressArabic
        self.latitude = latitude
        self.longitude = longitude
        self.isActive = isActive
        self.createdDate = createdDate
        self.updatedDate = updatedDate
    }
}
