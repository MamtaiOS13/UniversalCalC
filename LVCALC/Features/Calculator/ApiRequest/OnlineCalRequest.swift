//
//  OnlineCalRequest.swift
//  LVCALC
//
//  Created by Mamta Sharma on 8/21/21.
//

import Foundation
class OnlineCalRequest: BaseService {
    public init(_ currency: String, _ value: String) {
        super.init()
        self.requestURL = ApiEndPoint.baseUrl + ApiEndPoint.getBlockChainValue
        self.requestQueryParam = "currency=" + currency + "&value=\(value)"
        self.requestType = .GET
    }
    public init(_ value: String) {
        super.init()
        self.requestURL = ApiEndPoint.baseUrl + ApiEndPoint.getBlockChainValue
        self.requestQueryParam = "currency=USD" + "&value=\(value)"
        self.requestType = .GET
    }
}
