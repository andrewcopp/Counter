//
//  CountInteractor.swift
//  Counter
//
//  Created by Andrew Copp on 11/29/17.
//  Copyright © 2017 Andrew Copp. All rights reserved.
//

import Foundation
import CoreData

class CountInteractor {
    
    let coreData: CoreData
    
    lazy var counter: Counter = {
        return Counter(managedCounter: self.managedCounter())
    }()
    
    init(coreData: CoreData) {
        self.coreData = coreData
    }
    
    func managedCounter() -> ManagedCounter {
        let request: NSFetchRequest = ManagedCounter.fetchRequest()
        let managedCounters: [ManagedCounter]
        do {
            managedCounters = try coreData.persistentContainer.viewContext.fetch(request)
        } catch {
            managedCounters = []
        }
        
        let managedCounter: ManagedCounter
        if managedCounters.count > 0 {
            managedCounter = managedCounters[0]
        } else {
            managedCounter = NSEntityDescription.insertNewObject(forEntityName: "Counter", into: coreData.persistentContainer.viewContext) as! ManagedCounter
        }
        
        return managedCounter
    }
    
    func increment(completion: (Int) -> ()) {
        self.counter.increment()
        let managedCounter: ManagedCounter = self.managedCounter()
        managedCounter.count = Int16(self.counter.count)
        completion(self.counter.count)
    }
    
    func decrement(success: (Int) -> (), failure: (Error) -> ()) {
        if let error = self.counter.decrement() {
            failure(error)
        } else {
            let managedCounter: ManagedCounter = self.managedCounter()
            managedCounter.count = Int16(self.counter.count)
            success(self.counter.count)
        }
    }
    
    func rename(title: String) {
        self.counter.title = title
        let managedCounter: ManagedCounter = self.managedCounter()
        managedCounter.title = title
    }
    
}
