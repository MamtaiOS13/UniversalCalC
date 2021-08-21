//
//  AppDelegate.swift
//  LVCALC
//
//  Created by Mamta Sharma on 8/19/21.
//

import UIKit
import Reachability
import SwiftMessages
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var reachability: Reachability?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        do {
            reachability = try Reachability()
            try reachability?.startNotifier()
        } catch {

        }
        reachability?.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        }
        reachability?.whenUnreachable = { _ in
            print("Not reachable")
            do {
                if let view = try? SwiftMessages.viewFromNib(named: "MessageView") as? MessageView {
                    view.iconImageView?.isHidden = true
                    view.iconLabel?.isHidden = true
                    view.button?.isHidden = true
                    view.configureTheme(.error)
                    view.configureContent(title: "Network Issue",
                                          body: "Please check your internet connection and try again")

                    SwiftMessages.show(view: view)
                }
            } catch {

            }
        }
        return true
    }

}
