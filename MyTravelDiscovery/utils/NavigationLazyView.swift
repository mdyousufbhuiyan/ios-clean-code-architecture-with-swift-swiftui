//
//  NavigationLazyView.swift
//  MyTravelDiscovery
//
//  Created by Md Yousuf Bhuiyan on 2/28/23.
//

import Foundation
import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
