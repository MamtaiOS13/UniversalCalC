//
//  CalculatorVCViewModelTest.swift
//  LVCALCTests
//
//  Created by Mamta Sharma on 8/21/21.
//

import XCTest
@testable import LVCALC

class CalculatorVCViewModelTest: BaseTestCase {

    lazy var viewModel = CalculatorVCViewModel()
    override func setUp() {
        super.setUp()
    }
    // MARK: - Test basic binary operations
    func testAdd() {
        // (2+2) = 4
        viewModel.performEnterNumer(2)
        viewModel.performOperation(BinaryOperators.add.rawValue)
        viewModel.performEnterNumer(2)
        viewModel.performActions(.equal)
        XCTAssertEqual(viewModel.currentDisplayValue, "4")
    }
    func testSub() {
        // (5-7) = -2
        viewModel.performEnterNumer(5)
        viewModel.performOperation(BinaryOperators.subtract.rawValue)
        viewModel.performEnterNumer(7)
        viewModel.performActions(.equal)
        XCTAssertEqual(viewModel.currentDisplayValue, "-2")
    }
    func testMultiply() {
        // (6*2) = 12
        viewModel.performEnterNumer(6)
        viewModel.performOperation(BinaryOperators.multiply.rawValue)
        viewModel.performEnterNumer(2)
        viewModel.performActions(.equal)
        XCTAssertEqual(viewModel.currentDisplayValue, "12")
    }
    func testMultiplyDouble() {
        // (6.8*2.55566) = 17.378488
        // but display should be 17.38
        viewModel.performEnterNumer(6)
        viewModel.performActions(.decimal)
        viewModel.performEnterNumer(8)
        // 6.8
        viewModel.performOperation(BinaryOperators.multiply.rawValue)

        // 2.55566
        viewModel.performEnterNumer(2)
        viewModel.performActions(.decimal)
        viewModel.performEnterNumer(5)
        viewModel.performEnterNumer(5)
        viewModel.performEnterNumer(5)
        viewModel.performEnterNumer(6)
        viewModel.performEnterNumer(6)

        // 17.378488
        // display = 17.38
        viewModel.performActions(.equal)
        XCTAssertEqual(viewModel.currentDisplayValue, "17.38")
    }
    func testDivide() {
        // (20/5) = 4
        viewModel.performEnterNumer(20)
        viewModel.performOperation(BinaryOperators.divide.rawValue)
        viewModel.performEnterNumer(5)
        viewModel.performActions(.equal)
        XCTAssertEqual(viewModel.currentDisplayValue, "4")
    }

    // MARK: - Test basic unary operations
    func testSin() {
        // sin(90) = 1
        viewModel.performEnterNumer(90)
        viewModel.performOperation(UnaryOperators.sin.rawValue)
        XCTAssertEqual(viewModel.currentDisplayValue, "1")
    }
    func testCos() {
        // sin(360) = 1
        viewModel.performEnterNumer(90)
        viewModel.performOperation(UnaryOperators.sin.rawValue)
        XCTAssertEqual(viewModel.currentDisplayValue, "1")
    }

    // MARK: - Test concat operations
    func testConcatOperation() {
        // (2+3)*4 = 20
        // 2+3
        viewModel.performEnterNumer(2)
        viewModel.performOperation(BinaryOperators.add.rawValue)
        viewModel.performEnterNumer(3)
        // *4
        viewModel.performOperation(BinaryOperators.multiply.rawValue)
        viewModel.performEnterNumer(4)
        // =20
        viewModel.performActions(.equal)
        XCTAssertEqual(viewModel.currentDisplayValue, "20")
    }

    func testSecondConcatOperation() {
        // ((((88/4)+4)-10)+9)*2 = 50
        // 88/4
        viewModel.performEnterNumer(88)
        viewModel.performOperation(BinaryOperators.divide.rawValue)
        viewModel.performEnterNumer(4)
        // +4
        viewModel.performOperation(BinaryOperators.add.rawValue)
        viewModel.performEnterNumer(4)
        // -10
        viewModel.performOperation(BinaryOperators.subtract.rawValue)
        viewModel.performEnterNumer(10)
        // +9
        viewModel.performOperation(BinaryOperators.add.rawValue)
        viewModel.performEnterNumer(9)
        // *2
        viewModel.performOperation(BinaryOperators.multiply.rawValue)
        viewModel.performEnterNumer(2)
        // =50
        viewModel.performActions(.equal)
        XCTAssertEqual(viewModel.currentDisplayValue, "50")
    }

    // MARK: - Test Manupulative operation

    func testConcatManupulativeOperation() {
        // 2+3 = 5 / 5 (/ -> - -> * ) 6
        // (= 30) + 5
        // = 35
        viewModel.performEnterNumer(2)
        viewModel.performOperation(BinaryOperators.add.rawValue)
        viewModel.performEnterNumer(3)

        // *
        viewModel.performOperation(BinaryOperators.divide.rawValue)
        viewModel.performOperation(BinaryOperators.subtract.rawValue)
        viewModel.performOperation(BinaryOperators.multiply.rawValue)

        viewModel.performEnterNumer(6)
        viewModel.performOperation(BinaryOperators.add.rawValue)
        // 30
        viewModel.performEnterNumer(5)

        viewModel.performActions(.equal)
        XCTAssertEqual(viewModel.currentDisplayValue, "35")
    }

    // MARK: - Test online operation
    func testCurrentValueSuccessCase() {
        viewModel.checkExchange("500") {(result: Result<Double, Error>) in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
    }
    func testCurrentValueFailCase() {
        viewModel.checkExchange("50sddf0") {(result: Result<Double, Error>) in
            switch result {
            case .success(let response):
                XCTAssertNil(response)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    // MARK: - Test clear calculator
    func testClearCalculator() {
        viewModel.clearCalculator()
        XCTAssertEqual(viewModel.lastOperation, .none)
    }
    // MARK: - Test number Validity
    func testValidity() {
        let value = viewModel.isValidNumberTouse("9999999999999999999999999999")
        XCTAssertEqual(value, false)
    }
    func testValidityOfActualNumber() {
        let value = viewModel.isValidNumberTouse("10")
        XCTAssertEqual(value, true)
    }
}
