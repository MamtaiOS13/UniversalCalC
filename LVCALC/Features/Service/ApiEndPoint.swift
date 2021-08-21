//
//  ApiEndPoint.swift
//  LVCALC
//
//  Created by Mamta Sharma on 8/21/21.
//

import Foundation

struct ApiEndPoint {
    static var getMovie: String {
        return "movie/550"
    }
    static var baseUrl: String {
        return "https://blockchain.info"
    }
    static var getBlockChainValue: String {
        return "/tobtc"
    }
}

enum ServiceError: String {
    case invalidResponse = "Something went wrong"
}
