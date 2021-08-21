//
//  ToggleVCViewModel.swift
//  LVCALC
//
//  Created by Mamta Sharma on 8/20/21.
//

import Foundation

class ToggleVCViewModel {
    var results = AppSettings.shared.currentSetting.operationArray
    func numberOfRowsInSection(_ section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return results.count
    }
    func numberOfSection() -> Int {
        return 2
    }
    func getUIModel(_ indexPath: IndexPath) -> OperationModel {
        let model = results[indexPath.row]
        return model
    }

}
