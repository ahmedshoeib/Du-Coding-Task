//
//  HomeViewModel.swift
//  DuCodingTask
//
//  Created by Ahmed Shoeib on 8/29/19.
//  Copyright © 2019 Du. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CoreData

class HomeViewModel {
    
    private let disposeBag = DisposeBag()
    private let homeRepository : HomeRepository
    let router : BaseRouter
    
    // Fields that bind to our view's
    var data: BehaviorRelay<[HomePayLoad]> = BehaviorRelay(value: [HomePayLoad]())
    var errorValue: BehaviorRelay<String?> = BehaviorRelay(value: "")
    let isLoading : BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    
    
    init(router:BaseRouter , homeRepository : HomeRepository = HomeRepository()) {
        self.router = router
        self.homeRepository = homeRepository
    }
    
    // getting all home data from url
    func getData() {
        
        self.isLoading.accept(true)
        
        self.homeRepository.getData()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] response in
            
            self?.isLoading.accept(false)
            
            if let payLoadArr = response.payLoad {
                let filteredPayLoad = payLoadArr
                    .filter({ $0.isActive ?? 0 == 1 && $0.isVisible ?? 0 == 1})
                
                
                self?.homeRepository.saveHomeData(homePayLoad: filteredPayLoad)
                self?.data.accept(filteredPayLoad)
                
                
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
    
    
    func collectionViewCellSelected(indexPath:IndexPath) {
        let payload = data.value[indexPath.row]
        
        if payload.sectionId == 10 {
            router.pushViewControllerWithtype(screenType: HomeViewRouter.HomeViewRouteType.findUsViewController(payload))
        }else if let externalLinl = payload.externalLink, externalLinl.isValidURL {
            var urlString = externalLinl;
            if !externalLinl.starts(with: "http://") && !externalLinl.starts(with: "https://") {
                urlString = "http://\(externalLinl)"
            }
            router.pushViewControllerWithtype(screenType: HomeViewRouter.HomeViewRouteType.detailsWebViewController(urlString))
        }else{
            self.errorValue.accept("Sorry There is no external valid extenral link")
        }
    }
}
