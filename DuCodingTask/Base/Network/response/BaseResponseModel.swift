//
//  BaseResponseModel.swift
//  DuCodingTask
//
//  Created by Ahmed Shoeib on 8/29/19.
//  Copyright © 2019 Du. All rights reserved.
//

import Foundation

class BaseResponseModel: Codable,Error {
    let response: Response?
    
    private enum CodingKeys: String, CodingKey {
        case response = "response"
    }
    
    
    init(response: Response?) {
        self.response = response
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.response = try container.decode(Response.self, forKey: .response)
    }
}

// MARK: - Response
class Response: Codable {
    let code: Int?
    let message: String?
    
    init(code: Int?, message: String?) {
        self.code = code
        self.message = message
    }
}

