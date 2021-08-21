//
//  Utility.swift
//  LVCALC
//
//  Created by Mamta Sharma on 8/20/21.
//

import Foundation
import Reachability
import SwiftMessages

class Utility {

    class func isReachable() -> Bool {
        do {
            let reach = try Reachability()
            if reach.connection == .unavailable {
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
                return false
            }
        } catch {

        }

        return true
    }

    class func showApiError(title: String, mess: String) {
        do {
            if let view = try? SwiftMessages.viewFromNib(named: "MessageView") as? MessageView {
                view.iconImageView?.isHidden = true
                view.iconLabel?.isHidden = true
                view.button?.isHidden = true
                view.configureTheme(.error)
                view.configureContent(title: title, body: mess)

                SwiftMessages.show(view: view)
            }
        }
    }
}
