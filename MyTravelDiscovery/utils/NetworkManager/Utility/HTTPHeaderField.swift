//
//
//  HTTPHeaderField.swift
//  MyTravelDiscovery
//
//  Created by Md Yousuf Bhuiyan on 2/27/23.
//

import Foundation

enum HTTPHeaderField: String {
    case acceptType = "Accept"
    case contentType = "Content-Type"
    case authentication = "Authorization"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
