//
//  BaseService.swift
//  LVCALC
//
//  Created by Mamta Sharma on 8/21/21.
//

import Foundation
class BaseService: Service {
    static var baseUrl: String?
    var requestType: RequestType = .GET
    var requestURL: String = ""
    var requestQueryParam: String = ""
    var requestParams: [String: Any]?
    var additionalHeaders: [String: String]?
    init() {
        self.additionalHeaders = ["Content-Type": "application/json" ]
    }
}
