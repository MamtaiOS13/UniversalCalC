//
//  AppSettings.swift
//  LVCALC
//
//  Created by Mamta Sharma on 8/20/21.
//

import Foundation
class AppSettings {
    static let shared = AppSettings()
    var currentSetting = SettingModel()
    private init() {
    }
}
