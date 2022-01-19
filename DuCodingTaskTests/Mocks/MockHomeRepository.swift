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

class HomeRepositoryMock: BaseRepository {
    
    typealias T = Observable<[HomeResponseModel]>

    
    // mock get data for HomeRepo
    func getData() -> Observable<[HomeResponseModel]> {
        return Observable.just([])
    }

}
