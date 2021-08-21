//
//  CalculatorVCViewModel.swift
//  LVCALC
//
//  Created by Mamta Sharma on 8/19/21.
//

import Foundation

extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
protocol CalculatorVCViewModelProtocol {
    var network: NetworkClientProtocol { get set }
}
protocol SetNameProtocal: AnyObject {
    func setDisplayText(_ text: String)
}

class CalculatorVCViewModel: CalProtocol,
                             CalculatorVCViewModelProtocol {

    var network: NetworkClientProtocol = ServiceManager()
    var operation: BinaryOperators = .none
    var lastOperation: BinaryOperators = .none
    var operandStack = StackOperation()
    var isOperatioJustPressed = false
    var currentOperationType: OperationType = .none
    var lastEnterNumber: Double = 0
    weak var delegate: SetNameProtocal!

    var currentDisplayValue = "" {
        didSet {
            var finalDisplayText = currentDisplayValue
             getOutputUITextFromNumber(&finalDisplayText)
                DispatchQueue.main.async {
                    self.delegate?.setDisplayText(finalDisplayText)
                }

        }
    }
    var isCurrentDisplayValueEmpty: Bool {
        return currentDisplayValue.trimmingCharacters(in:
                                                        NSCharacterSet.whitespaces).count > 0 ? false : true
    }
    func setCurrentOperationType(_ tag: Int) {
        if tag > AllOperationTags.add.rawValue {
            currentOperationType = .unary
        } else {
            currentOperationType = .binary
        }
    }

    func performOperation(_ tag: Int) {
        setCurrentOperationType(tag)
        handleCurrentOperatorClicked(tag)
    }

    func handleCurrentOperatorClicked(_ tag: Int) {
        switch currentOperationType {
        case .unary:
            let operation = UnaryOperators(rawValue: tag) ?? .none
            unaryCalculationHandling(operation)
        case .binary:
            let operations = BinaryOperators(rawValue: tag) ?? .none
            operation = operations
            binaryCalculationHandling(operation)
        case .none:
            print("no action required")
        }
    }

    func performEnterNumer(_ number: Int) {
        if isOperatioJustPressed == false {
            if number != 0 {
                numberEnterIsNotZero(number)
            } else {
                numberEnterIsZero(number)
            }
        } else {
            isOperatioJustPressed = false
            currentDisplayValue = "\(number)"
        }

        guard !isCurrentDisplayValueEmpty,
              let lastNumber: Double = Double(currentDisplayValue) else {
            return
        }
        lastEnterNumber = lastNumber
    }
}

// MARK: - All Utilities handling

extension CalculatorVCViewModel {

    func numberEnterIsZero(_ number: Int) {
        if !isCurrentDisplayValueEmpty {
            currentDisplayValue += "0"
        } else {
            currentDisplayValue = ""
        }
    }

    func numberEnterIsNotZero(_ number: Int) {
        if !isCurrentDisplayValueEmpty {
            currentDisplayValue += "\(number)"
        } else {
            currentDisplayValue = "\(number)"
        }
    }

    func isValidNumberTouse(_ numberString: String) -> Bool {
        guard let newValue = Double(numberString) else {
            return false
        }
        guard Double(Int.min) <= newValue && newValue <= Double(Int.max) else {
            Utility.showApiError(title: "Alert", mess: "Large numbers are not supported by calculator")
            return false
        }
        return true
    }
    func checkValidity(_ value: Double) {
        guard isValidNumberTouse("\(value)") == true else {
            return
        }
        if Double(Int(value)) == value {
            currentDisplayValue = "\(Int(value))"
        } else {
            currentDisplayValue = "\(value)"
        }
    }
    func enterValueOnToStack() {
        if let value  = operandStack.peek() {
            checkValidity(value)
        }
    }
    func getOutputUITextFromNumber(_ finalDisplayText: inout String) {
        guard isValidNumberTouse(finalDisplayText) == true else {
            return
        }
        if let getDisplayDoubleValue = Double(finalDisplayText) {
            if getDisplayDoubleValue > 0 {
                if Double(Int(getDisplayDoubleValue)) == getDisplayDoubleValue {
                    if "\(getDisplayDoubleValue)".contains("e+") {
                        finalDisplayText = "\(getDisplayDoubleValue)"
                    } else {
                        finalDisplayText = "\(Int(getDisplayDoubleValue))"
                    }
                } else {
                    finalDisplayText = "\(getDisplayDoubleValue)"
                }
            }
        }
    }
}

// MARK: - All unary operation hanlding
extension CalculatorVCViewModel {

    func unaryCalculationHandling(_ uniaryOperation: UnaryOperators) {
        guard !isCurrentDisplayValueEmpty, let operand: Double = Double(currentDisplayValue) else {
            return
        }
        operandStack.emptyStack()
        var finalValue: Double?
        switch uniaryOperation {
        case .sin:
            finalValue = sindeg(degrees: operand)
        case .cos:
            finalValue = cosdeg(degrees: operand)
        case .none:
            print("no action required")
        }
        guard let value = finalValue else {
            return
        }
        checkValidity(value)
    }

}

// MARK: - All binary operation hanlding
extension CalculatorVCViewModel {

    func binaryCalculationHandling(_ operators: BinaryOperators) {
        guard !isCurrentDisplayValueEmpty, let operand: Double = Double(currentDisplayValue) else {
            return
        }
        operatorClickAction(operand: operand.round(to: 2), operationPassed: operation)
    }
    func operatorClickAction(operand: Double, operationPassed: BinaryOperators) {
        if operandStack.isEmpty {
            operandStack.push(operand)
            operation =  operationPassed
            lastOperation = operation
            isOperatioJustPressed = true
        } else if isOperatioJustPressed == false {
            if lastOperation == .none {
                lastOperation = operation
            }
            operation =  operationPassed
            if !operandStack.isEmpty {
                manageFinalOperationAction(operand, lastOperation)
                enterValueOnToStack()
            }
            lastOperation = operation
            isOperatioJustPressed = true
        } else {
            operation =  operationPassed
            lastOperation = operation
        }
    }
    func manageFinalOperationAction(_ operand: Double, _ operators: BinaryOperators) {
        let lastItem = operandStack.pop()
        var finalValue: Double?

        switch operators {
        case .add:
            finalValue = addition(lastItem, operand)
        case .subtract:
            finalValue = subtract(lastItem, operand)
        case .multiply:
            finalValue = multiply(lastItem, operand)
        case .divide:
            finalValue = division(lastItem, operand)
        case .none:
            print("no action required")
        }

        guard let value = finalValue else {
            return
        }
        print(value.round(to: 2))
        operandStack.push(value.round(to: 2))
    }
}

// MARK: - All actions hanlding
extension CalculatorVCViewModel {
    func performActions(_ actionType: Actions) {
        switch actionType {
        case .clear:
            clearCalculator()
        case .decimal:
            decimalAction()
        case .equal:
            equalCalculationHandling()
        case .none:
            print("no action required")
        }
    }
    func decimalAction() {
        guard !isCurrentDisplayValueEmpty else {
            return
        }
        if !currentDisplayValue.contains(".") {
            currentDisplayValue += "."
        }
    }
    func clearCalculator() {
        operation = .none
        currentDisplayValue = ""
        operandStack.emptyStack()
        currentOperationType = .none
        lastEnterNumber = 0
        isOperatioJustPressed = false
        lastOperation = .none
    }
    func equalCalculationHandling() {
        if currentOperationType == .binary && isOperatioJustPressed == false {
            if !operandStack.isEmpty {
                manageFinalOperationAction(lastEnterNumber, lastOperation)
                enterValueOnToStack()
            }
        }
        isOperatioJustPressed = false
    }
}
