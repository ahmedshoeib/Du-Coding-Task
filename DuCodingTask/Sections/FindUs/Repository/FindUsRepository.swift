//
//  FindUsRepository.swift
//  DuCodingTask
//
//  Created by Ahmed Shoeib on 8/31/19.
//  Copyright © 2019 Du. All rights reserved.
//

import RxSwift
import RxCocoa
import CoreData

class FindUsRepository : BaseRepository {
    
    typealias T = Observable<NearestShopResponseModel>

    private let networManager : NetworkManagerProtocol
    
    
    init(networManager:NetworkManagerProtocol = NetworkManager()) {
        self.networManager = networManager
    }
    
    func getData() -> Observable<NearestShopResponseModel> {
        
        let context = AppDelegate.shared.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ShopEntity")
        
        do {
            let fetchedHomeData = try context.fetch(fetchRequest) as! [ShopEntity]
            
            if fetchedHomeData.count == 0 {
                return self.getDataFromNerwork()
            }
            
            
            let nearestShopPayLoad = fetchedHomeData.map({ (shopEntity) -> NearestShopPayLoad in
                    return NearestShopPayLoad(locationId: Int(shopEntity.locationId), locationSection: Int(shopEntity.locationSection), title: shopEntity.title, titleArabic: shopEntity.titleArabic, hourOperation: shopEntity.hourOperation, address: shopEntity.address, addressArabic: shopEntity.addressArabic, latitude: shopEntity.latitude, longitude: shopEntity.longitude, isActive: shopEntity.isActive ? 1 : 0, createdDate: Int(shopEntity.createdDate), updatedDate: Int(shopEntity.updatedDate))
            })
            
            return Observable.just(NearestShopResponseModel(response: nil, payLoad: nearestShopPayLoad))
        } catch {
            return self.getDataFromNerwork()
        }
    }
    
    
    func saveHomeData(nearestShopPayLoad : [NearestShopPayLoad])  {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ShopEntity")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            
            let context = AppDelegate.shared.managedObjectContext
            
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
            }
            
            if let entity =  NSEntityDescription.entity(forEntityName: "ShopEntity", in: context) {
                for payLoad in nearestShopPayLoad {
                    _ = ShopEntity(address: payLoad.address, addressArabic: payLoad.addressArabic, createdDate: Int64(payLoad.createdDate ?? 0), hourOperation: payLoad.hourOperation, isActive: payLoad.isActive ?? 0 == 1, latitude: payLoad.latitude ?? 0.0, locationId: Int64(payLoad.locationId ?? 0), locationSection: Int64(payLoad.locationSection ?? 0), longitude: payLoad.longitude ?? 0, title: payLoad.title, titleArabic: payLoad.titleArabic, updatedDate: Int64(payLoad.updatedDate ?? 0), entity: entity, context: context)
                    try context.save()
                }
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func getDataFromNerwork() -> Observable<NearestShopResponseModel> {
        return  networManager.executeRequest(url: "114kkf", requestDictionary: nil, method: .get, additionnalHeaders: nil, responseModel: NearestShopResponseModel.self)
    }
}
