//
//  FindUsViewModel.swift
//  DuCodingTask
//
//  Created by Ahmed Shoeib on 8/30/19.
//  Copyright © 2019 Du. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

class FindUsViewModel {
    
    private let disposeBag = DisposeBag()
    private let findUsRepository : FindUsRepository
    let router : BaseRouter

    private var duShops = [NearestShopPayLoad]()
    
    // Fields that bind to our view's
    var data: BehaviorRelay<[NearestShopPayLoad]> = BehaviorRelay(value: [NearestShopPayLoad]())
    var mapAnnotation: BehaviorRelay<[ShopAnnotation]> = BehaviorRelay(value: [ShopAnnotation]())
    
    var errorValue: BehaviorRelay<String?> = BehaviorRelay(value: "")
    let isLoading : BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    let searchText = PublishSubject<String?>()
    
    init(router:BaseRouter , findUsRepository : FindUsRepository = FindUsRepository()) {
        self.router = router
        self.findUsRepository = findUsRepository
        
        setupBundings()
    }
    
    
    func setupBundings() {
        
        searchText
            .flatMapLatest({ [weak self] locationName -> Observable<[NearestShopPayLoad]> in
                
                guard let `self` = self else {
                    return Observable.just([])
                }
                
                guard let locationName = locationName,locationName.count > 0 else {
                    return Observable.just(self.duShops)
                }
                
                return Observable.just(self.duShops.filter({ $0.title?.lowercased().contains(locationName.lowercased()) ?? false}))
            })
            .subscribe(onNext: { [weak self] shops in
                
                self?.data.accept(shops)
                
                }, onError: { [weak self] error in
                    
                    self?.isLoading.accept(false)
                    self?.data.accept([])

            })
            .disposed(by: disposeBag)
    }
    
    func getNearestShopOrderedBy(currentLocation : CLLocation) {
        
        self.isLoading.accept(true)
        
        self.findUsRepository.getData()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] response in
            
            self?.isLoading.accept(false)
            
            
            if var shopsArr = response.payLoad {
                
                shopsArr.sort { (shop1, shop2) -> Bool in
                    
                    let shop1Distance = CLLocation(latitude: shop1.latitude ?? 0.0,longitude: shop1.longitude ?? 0.0).distance(from: currentLocation)
                    let shop2Distance = CLLocation(latitude: shop2.latitude ?? 0.0,longitude: shop2.longitude ?? 0.0).distance(from: currentLocation)
                    
                    shop1.distance = String(format: "%.02f km", shop1Distance / 1000)
                    shop2.distance = String(format: "%.02f km", shop2Distance / 1000)
                    
                    return shop1Distance < shop2Distance
                }
                
                
                let shopAnnotationArr = shopsArr.map({ (shop) -> ShopAnnotation in
                    return ShopAnnotation(title: shop.title ?? "", locationName: shop.address ?? "", coordinate: CLLocation(latitude: shop.latitude ?? 0.0,longitude: shop.longitude ?? 0.0).coordinate)
                })
                
                self?.duShops = shopsArr
                
                self?.findUsRepository.saveHomeData(nearestShopPayLoad: shopsArr)
                self?.data.accept(shopsArr)
                self?.mapAnnotation.accept(shopAnnotationArr)
                
                
            }else{
                self?.errorValue.accept("Someting went wrong")
            }
            
            
            }, onError: { [weak self] (error) in
                
                self?.isLoading.accept(false)
                
                if let baseResponseModel = error as? BaseResponseModel {
                    self?.errorValue.accept(baseResponseModel.response?.message ?? "Someting went wrong")
                }else{
                    self?.errorValue.accept(error.localizedDescription)
                }
                
        }).disposed(by: disposeBag)
        
    }
    
    func shopSelectedAtIndex(indexPath:IndexPath,currentLocation:CLLocation?) {
        let shop = data.value[indexPath.row]

        guard  let fromLocation = currentLocation, let lat = shop.latitude, let lng = shop.longitude  else {
            return
        }

        
        router.pushViewControllerWithtype(screenType: FindUsRouter.FindUsViewRouteType.route(fromLocation.coordinate.latitude, fromLocation.coordinate.longitude, lat, lng, shop.title))

    }
    
}

