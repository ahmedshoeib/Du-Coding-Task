//
//  HomeResponseModel.swift
//  DuCodingTask
//
//  Created by Ahmed Shoeib on 8/29/19.
//  Copyright © 2019 Du. All rights reserved.
//

class HomeResponseModel: BaseResponseModel {
    let payLoad: [HomePayLoad]?
    
    private enum CodingKeys: String, CodingKey {
        case homePayLoad = "payLoad"
    }
    
    init(response: Response?, payLoad: [HomePayLoad]?) {
        self.payLoad = payLoad
        super.init(response: response)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let elements = try container.decode([FailableDecodable<HomePayLoad>].self, forKey: .homePayLoad)
        self.payLoad = elements.compactMap { $0.base }
        try super.init(from: decoder)
    }
}

// MARK: - PayLoad
class HomePayLoad: Codable {
    let sectionId: Int?
    let title, titleArabic: String?
    let titleColor: String?
    let shortDesc, shortDescArabic: String?
    let shortDescColor: String?
    let imagePath: String?
    let position, isActive, isVisible, isCMSAPI: Int?
    let isTileView, isCMSSection, isDeletable, createdDate: Int?
    let updatedDate, isLink: Int?
    let externalLink, externalLinkArabic: String?
    
    enum CodingKeys: String, CodingKey {
        case sectionId
        case title, titleArabic, titleColor, shortDesc, shortDescArabic, shortDescColor, imagePath, position, isActive, isVisible
        case isCMSAPI
        case isTileView
        case isCMSSection
        case isDeletable, createdDate, updatedDate, isLink, externalLink, externalLinkArabic
    }
    
    
    init(sectionId: Int?, title: String?, titleArabic: String?, titleColor: String?, shortDesc: String?, shortDescArabic: String?, shortDescColor: String?, imagePath: String?, position: Int?, isActive: Int?, isVisible: Int?, isCMSAPI: Int?, isTileView: Int?, isCMSSection: Int?, isDeletable: Int?, createdDate: Int?, updatedDate: Int?, isLink: Int?, externalLink: String?, externalLinkArabic: String?) {
        self.sectionId = sectionId
        self.title = title
        self.titleArabic = titleArabic
        self.titleColor = titleColor
        self.shortDesc = shortDesc
        self.shortDescArabic = shortDescArabic
        self.shortDescColor = shortDescColor
        self.imagePath = imagePath
        self.position = position
        self.isActive = isActive
        self.isVisible = isVisible
        self.isCMSAPI = isCMSAPI
        self.isTileView = isTileView
        self.isCMSSection = isCMSSection
        self.isDeletable = isDeletable
        self.createdDate = createdDate
        self.updatedDate = updatedDate
        self.isLink = isLink
        self.externalLink = externalLink
        self.externalLinkArabic = externalLinkArabic
    }
}
