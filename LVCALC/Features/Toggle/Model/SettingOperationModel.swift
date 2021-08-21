//
//  SettingOperationModel.swift
//  LVCALC
//
//  Created by Mamta Sharma on 8/20/21.
//

import Foundation

enum OperationTags: Int {
    case divide = 201
    case multiply
    case subtract
    case add
    case sin
    case cos
}

class SettingModel {
    var operationArray = [ OperationModel("Divide", isOn: true, tag: .divide),
                           OperationModel("Multiply", isOn: true, tag: .multiply),
                           OperationModel("Subttract", isOn: true, tag: .subtract),
                           OperationModel("Add", isOn: true, tag: .add),
                           OperationModel("Sin", isOn: true, tag: .sin),
                           OperationModel("Cos", isOn: true, tag: .cos) ]
}

class OperationModel {
    var name: String?
    var isOn: Bool = true
    var tag: OperationTags = .add
    init(_ name: String, isOn: Bool, tag: OperationTags) {
        self.name = name
        self.isOn = isOn
        self.tag = tag
    }
}
