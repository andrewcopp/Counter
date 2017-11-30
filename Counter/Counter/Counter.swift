//
//  Counter.swift
//  Counter
//
//  Created by Andrew Copp on 11/29/17.
//  Copyright © 2017 Andrew Copp. All rights reserved.
//

import Foundation

struct Counter {
    
    var count: Int
    
    init(count: Int = 0) {
        self.count = count
    }
    
    mutating func increment() {
        self.count = self.count + 1
    }
    
    mutating func decrement() {
        self.count = self.count - 1
    }
    
}
