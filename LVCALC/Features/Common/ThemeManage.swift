//
//  ThemeManage.swift
//  LVCALC
//
//  Created by Mamta Sharma on 8/20/21.
//

import UIKit
import Foundation

enum Theme: Int {

    case theme1, theme2

    var mainColor: UIColor {
        switch self {
        case .theme1:
            return  UIColor.white
        case .theme2:
            return UIColor.black
        }
    }

    var backgroundColor: UIColor {
        switch self {
        case .theme1:
            return UIColor.black
        case .theme2:
            return UIColor.white
        }
    }

    var titleTextColor: UIColor {
        switch self {
        case .theme1:
            return  UIColor.white
        case .theme2:
            return UIColor.black
        }
    }
    var smallViewColor: UIColor {
        switch self {
        case .theme1:
            return UIColor.systemOrange
        case .theme2:
            return UIColor(red: 0.0/255.0, green: 206/255.0, blue: 209/255.0, alpha: 0.80)
        }
    }
    var barStyle: UIBarStyle {
        switch self {
        case .theme1:
            return .default
        case .theme2:
            return .black
        }
    }
    var switchStyle: UIColor {
        switch self {
        case .theme1:
            return  UIColor.white
        case .theme2:
            return UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        }
    }
}

class ThemeManager {
    static let shared = ThemeManager()
    var theme: Theme = .theme2
    private init() {
        theme = currentTheme()
        applyActualTheme()
    }
    func currentTheme() -> Theme {
        if let storedTheme = (UserDefaults.standard.value(forKey: "currentTheme") as AnyObject).integerValue {
            return Theme(rawValue: storedTheme)!
        } else {
            return .theme2
        }
    }
    func applyTheme(theme: Theme) {
        UserDefaults.standard.setValue(theme.rawValue, forKey: "currentTheme")
        UserDefaults.standard.synchronize()
        let sharedApplication = UIApplication.shared
        sharedApplication.delegate?.window??.tintColor = theme.mainColor
        UINavigationBar.appearance().barStyle = theme.barStyle
        self.theme = currentTheme()
    }
    func applyActualTheme() {
        let sharedApplication = UIApplication.shared
        sharedApplication.delegate?.window??.tintColor = theme.mainColor
    }

}
