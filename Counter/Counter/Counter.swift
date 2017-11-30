//
//  Counter.swift
//  Counter
//
//  Created by Andrew Copp on 11/29/17.
//  Copyright © 2017 Andrew Copp. All rights reserved.
//

import Foundation

enum CounterError: Error {
    case decrementZero
}

struct Counter {
    
    var count: Int
    
    init(count: Int = 0) {
        self.count = count
    }
    
    init(managedCounter: ManagedCounter) {
        self.count = Int(managedCounter.count)
    }
    
    mutating func increment() {
        self.count = self.count + 1
    }
    
    mutating func decrement() -> Error? {
        guard self.count > 0 else {
            return CounterError.decrementZero
        }
        
        self.count = self.count - 1
        return nil
    }
    
}
