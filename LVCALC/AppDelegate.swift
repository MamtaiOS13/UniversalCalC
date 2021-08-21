//
//  AppDelegate.swift
//  LVCALC
//
//  Created by Mamta Sharma on 8/19/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        sleep(3)
        AppManager.shareManager.setInitialSetting()
        return true
    }

}
