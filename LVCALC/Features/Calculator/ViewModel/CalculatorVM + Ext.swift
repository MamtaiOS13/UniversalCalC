//
//  CalculatorVM + Ext.swift
//  LVCALC
//
//  Created by Mamta Sharma on 8/21/21.
//

import Foundation

extension CalculatorVCViewModel {
    func addition(_ operand1: Double, _ operand2: Double) -> Double {
        return operand2 + operand1
    }
    func subtract(_ operand1: Double, _ operand2: Double) -> Double {
        return operand1 - operand2
    }
    func multiply(_ operand1: Double, _ operand2: Double) -> Double {
        return operand2 * operand1
    }
    func division(_ operand1: Double, _ operand2: Double) -> Double {
        if operand2 == Double(0) {
            print("Inf")
        }
        return operand1 / operand2
    }
    func sindeg(degrees: Double) -> Double {
        return sin(degrees * .pi / 180.0)
    }
    func cosdeg(degrees: Double) -> Double {
        return cos(degrees * .pi / 180.0)
    }
    func checkExchange(_ value: String, completion: @escaping ServiceResponse<Double>) {
        _ = network.start(type: Double.self,
                          OnlineCalRequest(value)) {(result: Result<Double, Error>) in
            completion(result)
        }
    }
}
