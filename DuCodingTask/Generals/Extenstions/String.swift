//
//  String.swift
//  DuCodingTask
//
//  Created by Ahmed Shoeib on 8/29/19.
//  Copyright © 2019 Du. All rights reserved.
//

import Foundation

extension String {
    var isValidURL: Bool {
        let urlRegEx = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
        return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: self)

    }
}
