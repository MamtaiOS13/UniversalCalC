//
//  AppManager.swift
//  LVCALC
//
//  Created by Mamta Sharma on 8/21/21.
//

import Foundation
import Reachability
import SwiftMessages
import Firebase

class AppManager {
    var reachability: Reachability?
    static let shareManager = AppManager()
    private init() {

    }
    func setInitialSetting() {
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
            }
        }
    }
}
