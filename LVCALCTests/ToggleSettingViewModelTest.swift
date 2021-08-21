//
//  ToggleSettingViewModelTest.swift
//  LVCALCTests
//
//  Created by Mamta Sharma on 8/21/21.
//

import XCTest
@testable import LVCALC

class ToggleSettingViewModelTest: BaseTestCase {
    lazy var viewModel = ToggleVCViewModel()
    override func setUp() {
        super.setUp()
    }
    func testNumerOfRows() {
        XCTAssertEqual(viewModel.numberOfRowsInSection(0), 1)
        XCTAssertEqual(viewModel.numberOfRowsInSection(1), AppSettings.shared.currentSetting.operationArray.count)
    }
    func testNumerOfSection() {
        XCTAssertEqual(viewModel.numberOfSection(), 2)
    }
    func testGetModel() {
        let index =  IndexPath(item: 0, section: 1)
        XCTAssertEqual(viewModel.getUIModel(index).name, AppSettings.shared.currentSetting.operationArray[0].name)
        let indexSecond =  IndexPath(item: 2, section: 1)
        XCTAssertEqual(viewModel.getUIModel(indexSecond).name, AppSettings.shared.currentSetting.operationArray[2].name)
    }
    func testDisableFeature() {
        let index =  IndexPath(item: 0, section: 1)
        let model = viewModel.getUIModel(index)
        model.isOn = false
        XCTAssertEqual(AppSettings.shared.currentSetting.operationArray[0].isOn, false)
    }
}
