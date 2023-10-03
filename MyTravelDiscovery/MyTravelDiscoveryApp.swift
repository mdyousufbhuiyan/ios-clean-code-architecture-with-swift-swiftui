//
//  MyTravelDiscoveryApp.swift
//  MyTravelDiscovery
//
//  Created by Md Yousuf Bhuiyan on 2/25/23.
//

import SwiftUI

@main
struct MyTravelDiscoveryApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            DiscoverView().colorScheme(.light)
        }
    }
}
import UIKit
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Your code here")
        return true
    }
    
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        print("..........................applicationDidFinishLaunching..............")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("..........................applicationWillEnterForeground..............")
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("..........................applicationDidBecomeActive..............")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        print("..........................applicationWillResignActive..............")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("..........................applicationDidEnterBackground..............")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("..........................applicationWillTerminate..............")
    }
    
}
