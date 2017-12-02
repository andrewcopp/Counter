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
    var title: String
    var identifier: Int
    
    init?(json: [String : AnyObject]) {
        guard let identifier: Int = json["id"] as? Int else {
            return nil
        }
        
        guard let title: String = json["name"] as? String else {
            return nil
        }
        
        guard let count: Int = json["count"] as? Int else {
            return nil
        }
        
        self.count = count
        self.title = title
        self.identifier = identifier
    }
    
    init(managedCounter: ManagedCounter) {
        self.count = Int(managedCounter.count)
        self.title = managedCounter.title ?? ""
        self.identifier = Int(managedCounter.identifier)
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
