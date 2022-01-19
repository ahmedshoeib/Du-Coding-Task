//
//  Codable.swift
//  CarWash
//
//  Created by Shoeib on 8/7/19.
//  Copyright © 2019 CarWash. All rights reserved.
//

import UIKit

struct JSON {
//    static let encoder = JSONEncoder()
}

extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    var dictionary: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        return (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] ?? [:]
    }
}
