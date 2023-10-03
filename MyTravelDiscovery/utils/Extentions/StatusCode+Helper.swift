//
//  StatusCode+Helper.swift
//  MyTravelDiscovery
//
//  Created by Md Yousuf Bhuiyan on 2/27/23.
//

import Foundation

extension StatusCode {
    var isSuccess: Bool {
        (200..<300).contains(self)
    }
}
