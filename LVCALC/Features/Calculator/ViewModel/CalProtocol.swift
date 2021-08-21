//
//  CalProtocol.swift
//  LVCALC
//
//  Created by Mamta Sharma on 8/19/21.
//

import Foundation

enum OperationType {
    case unary
    case binary
    case none
}

enum BinaryOperators: Int {
    case divide = 201
    case multiply
    case subtract
    case add
    case none
}

enum UnaryOperators: Int {
    case sin = 205
    case cos
    case none
}

enum Actions: Int {
    case clear = 100
    case decimal
    case equal
    case none
}

enum AllOperationTags: Int {
    case divide = 201
    case multiply
    case subtract
    case add
    case sin
    case cos
}

protocol CalProtocol {
    func clearCalculator()
    func equalCalculationHandling()
    func unaryCalculationHandling(_ uniaryOperation: UnaryOperators)
    func binaryCalculationHandling(_ operators: BinaryOperators)
}
