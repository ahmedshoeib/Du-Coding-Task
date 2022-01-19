//
//  MockHomeRepository.swift
//  DuCodingTaskTests
//
//  Created by Ahmed Shoeib on 8/31/19.
//  Copyright © 2019 Du. All rights reserved.
//

import Foundation
import RxSwift

@testable import DuCodingTask

class FindUsRepositoryMock: BaseRepository {
    
    typealias T = Observable<[NearestShopResponseModel]>

    
    // mock get data for HomeRepo
    func getData() -> Observable<[NearestShopResponseModel]> {
        return Observable.just([])
    }

}
