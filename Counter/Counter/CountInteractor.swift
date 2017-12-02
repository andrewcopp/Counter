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
    
    var identifier: Int?
    let coreData: CoreData
    
    lazy var counter: Counter = {
        return Counter(managedCounter: self.managedCounter())
    }()
    
    init(identifier: Int?, coreData: CoreData) {
        self.identifier = identifier
        self.coreData = coreData
    }
    
    func managedCounter() -> ManagedCounter {
        let managedCounters: [ManagedCounter] = self.managedCounters()
        
        let managedCounter: ManagedCounter
        if let identifier: Int = self.identifier {
            if let index = managedCounters.index(where: { Int($0.identifier) == identifier }) {
                managedCounter = managedCounters[index]
            } else {
                managedCounter = createManagedCounter()
                self.identifier = Int(managedCounter.identifier)
            }
        } else {
            managedCounter = createManagedCounter()
            self.identifier = Int(managedCounter.identifier)
        }
        
        return managedCounter
    }
    
    func managedCounters() -> [ManagedCounter] {
        let request: NSFetchRequest = ManagedCounter.fetchRequest()
        
        let managedCounters: [ManagedCounter]
        do {
            managedCounters = try self.coreData.persistentContainer.viewContext.fetch(request)
        } catch {
            managedCounters = []
        }
        
        return managedCounters
    }
    
    func createManagedCounter() -> ManagedCounter {
        let managedCounter: ManagedCounter = NSEntityDescription.insertNewObject(forEntityName: "Counter", into: coreData.persistentContainer.viewContext) as! ManagedCounter
        let identifiers: [Int] = self.managedCounters().map({ Int($0.identifier) })
        
        var i = arc4random_uniform(1000)
        while identifiers.contains(Int(i)) {
            i = arc4random_uniform(1000)
        }
        
        managedCounter.identifier = Int16(i)
        managedCounter.title = "Unnamed Counter"
        
        self.coreData.saveContext()
        NotificationCenter.default.post(name: Notification.Name.init("CounterCountersDidUpdate"), object: nil, userInfo: nil)
        
        return managedCounter
    }
    
    func increment(completion: (Int) -> ()) {
        self.counter.increment()
        let managedCounter: ManagedCounter = self.managedCounter()
        managedCounter.count = Int16(self.counter.count)
        completion(self.counter.count)
        self.coreData.saveContext()
        NotificationCenter.default.post(name: Notification.Name.init("CounterCountersDidUpdate"), object: nil, userInfo: nil)
    }
    
    func decrement(success: (Int) -> (), failure: (Error) -> ()) {
        if let error = self.counter.decrement() {
            failure(error)
        } else {
            let managedCounter: ManagedCounter = self.managedCounter()
            managedCounter.count = Int16(self.counter.count)
            success(self.counter.count)
            self.coreData.saveContext()
            NotificationCenter.default.post(name: Notification.Name.init("CounterCountersDidUpdate"), object: nil, userInfo: nil)
        }
    }
    
    func rename(title: String) {
        self.counter.title = title
        let managedCounter: ManagedCounter = self.managedCounter()
        managedCounter.title = title
        self.coreData.saveContext()
        NotificationCenter.default.post(name: Notification.Name.init("CounterCountersDidUpdate"), object: nil, userInfo: nil)
    }
    
}
