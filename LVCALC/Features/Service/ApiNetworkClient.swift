//
//  ApiNetworkClient.swift
//  LVCALC
//
//  Created by Mamta Sharma on 8/21/21.
//

import Foundation

protocol NetworkClientProtocol {
    func start<T: Codable>(type: T.Type,
                           _ service: Service,
                           completion: @escaping ServiceResponse<T>) -> URLSessionDataTask?
}
