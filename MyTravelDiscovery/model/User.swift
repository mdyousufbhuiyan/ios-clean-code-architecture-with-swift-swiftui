//
//  User.swift
//  MyTravelDiscovery
//
//  Created by Md Yousuf Bhuiyan on 6/3/23.
//

import Foundation

struct User: Hashable {
    var id: Int
    let name, imageName: String
    func greetThenRunClosure(name: String, closure: () -> (),z:String) {
        print("Hello, \(name)!")
        closure()
    }
}
