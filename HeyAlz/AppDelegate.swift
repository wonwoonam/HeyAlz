//
//  AppDelegate.swift
//  HeyAlz
//
//  Created by Won Woo Nam on 10/21/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Unity.shared.setHostMainWindow(window)
        return true
    }

    // MARK: UISceneSession Lifecycle

    

}

