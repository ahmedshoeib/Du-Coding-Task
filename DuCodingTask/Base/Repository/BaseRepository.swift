//
//  BaseRepository.swift
//  DuCodingTask
//
//  Created by Ahmed Shoeib on 8/31/19.
//  Copyright © 2019 Du. All rights reserved.
//

protocol BaseRepository {
    associatedtype T
    func getData() -> T
}

