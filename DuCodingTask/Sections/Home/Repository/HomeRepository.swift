//
//  HomeRepository.swift
//  DuCodingTask
//
//  Created by Ahmed Shoeib on 8/31/19.
//  Copyright © 2019 Du. All rights reserved.
//

import RxSwift
import RxCocoa
import CoreData

class HomeRepository : BaseRepository{
    
    typealias T = Observable<HomeResponseModel>
    
    private let networManager : NetworkManagerProtocol
    
    
    init(networManager:NetworkManagerProtocol = NetworkManager()) {
        self.networManager = networManager
    }
    
    func getData() -> Observable<HomeResponseModel> {
        
        let context = AppDelegate.shared.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HomeEntity")
        
        do {
            let fetchedHomeData = try context.fetch(fetchRequest) as! [HomeEntity]
            
            if fetchedHomeData.count == 0 {
                return self.getDataFromNerwork()
            }
            
            
            let homePayLoad = fetchedHomeData.map({ (homeEntity) -> HomePayLoad in
                
                let homePayLoad = HomePayLoad(sectionId: Int(homeEntity.sectionId ), title: homeEntity.title, titleArabic: homeEntity.titleArabic, titleColor: homeEntity.titleColor, shortDesc: homeEntity.shortDesc, shortDescArabic: homeEntity.shortDescArabic, shortDescColor: homeEntity.shortDescColor, imagePath: homeEntity.imagePath, position: Int(homeEntity.position ), isActive: homeEntity.isActive ? 1 : 0, isVisible: homeEntity.isVisible ? 1 : 0, isCMSAPI: homeEntity.isCmsApi ? 1 : 0, isTileView: homeEntity.isTileView ? 1 : 0, isCMSSection: homeEntity.isCmsSection ? 1 : 0, isDeletable: homeEntity.isDeletable ? 1 : 0, createdDate: Int(homeEntity.createdDate ), updatedDate: Int(homeEntity.updatedDate ), isLink: homeEntity.isLink ? 1 : 0, externalLink: homeEntity.externalLink, externalLinkArabic: homeEntity.externalLinkArabic)
                
                return homePayLoad
            })
            
            return Observable.just(HomeResponseModel(response: nil, payLoad: homePayLoad))
            
        } catch {
            return self.getDataFromNerwork()
        }
    }
    
    
    private func getDataFromNerwork() -> Observable<HomeResponseModel> {
        return  networManager.executeRequest(url: "19kxcv", requestDictionary: nil, method: .get, additionnalHeaders: nil, responseModel: HomeResponseModel.self)
    }
    
    
    func saveHomeData(homePayLoad : [HomePayLoad])  {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HomeEntity")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            
            let context = AppDelegate.shared.managedObjectContext
            
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
            }
            
            if let entity =  NSEntityDescription.entity(forEntityName: "HomeEntity", in: context) {
                for payLoad in homePayLoad {
                    _ = HomeEntity(createdDate: Int64(payLoad.createdDate ?? 0), externalLink: payLoad.externalLink, externalLinkArabic: payLoad.externalLinkArabic, imagePath: payLoad.imagePath, isActive: payLoad.isActive ?? 0 == 1, isCmsApi: payLoad.isCMSAPI ?? 0 == 1, isCmsSection: payLoad.isCMSSection ?? 0 == 1, isDeletable: payLoad.isDeletable ?? 0 == 1, isLink: payLoad.isLink ?? 0 == 1, isTileView: payLoad.isTileView ?? 0 == 1, isVisible: payLoad.isVisible ?? 0 == 1, position: Int64(payLoad.position ?? 0), sectionId: Int64(payLoad.sectionId ?? 0), shortDesc: payLoad.shortDesc, shortDescArabic: payLoad.shortDescArabic, shortDescColor: payLoad.shortDescColor, title: payLoad.title, titleArabic: payLoad.titleArabic, titleColor: payLoad.titleColor, updatedDate: Int64(payLoad.updatedDate ?? 0), entity:entity, context: context)
                    try context.save()
                }
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
