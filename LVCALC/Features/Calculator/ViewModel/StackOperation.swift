//
//  StackOperation.swift
//  LVCALC
//
//  Created by Mamta Sharma on 8/20/21.
//

import Foundation

struct StackOperation {
    var items = [Double]()
    var isEmpty: Bool {
        return items.count == 0 ? true : false
    }
    mutating func push(_ item: Double) {
        items.append(item)
    }
    mutating func pop() -> Double {
        return items.removeLast()
    }
    mutating func emptyStack() {
         items.removeAll()
    }
    mutating func peek() -> Double? {
        return items[0]
    }
}
var stackOperation  = StackOperation()
