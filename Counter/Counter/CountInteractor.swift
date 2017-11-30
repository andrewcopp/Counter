//
//  CountInteractor.swift
//  Counter
//
//  Created by Andrew Copp on 11/29/17.
//  Copyright © 2017 Andrew Copp. All rights reserved.
//

import Foundation

class CountInteractor {
    
    var counter: Counter = Counter()
    
    func increment(completion: (Int) -> ()) {
        self.counter.increment()
        completion(self.counter.count)
    }
    
    func decrement(success: (Int) -> (), failure: (Error) -> ()) {
        if let error = self.counter.decrement() {
            failure(error)
        } else {
            success(self.counter.count)
        }
    }
    
}
