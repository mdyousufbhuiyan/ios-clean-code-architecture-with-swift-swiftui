//
//
//  MyEnvironment.swift
//  MyTravelDiscovery
//
//  Created by Md Yousuf Bhuiyan on 2/27/23.
//
import Foundation

typealias StatusCode = Int
let kTimeoutInterval: TimeInterval = 30.0
let kNetworkEnvironment: MyEnvironment = .development
let kRequestCachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData

enum MyEnvironment: String, CaseIterable {
    case beta
    case development
    case production
}

extension MyEnvironment {
    var baseURL: String {
        switch self {
        case .beta:
            return "https://travel.letsbuildthatapp.com/"
        case .development:
            return "https://travel.letsbuildthatapp.com/"
        case .production:
            return "https://travel.letsbuildthatapp.com/"
        }
    }
}
