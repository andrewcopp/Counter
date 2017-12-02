//
//  ListInteractor.swift
//  Counter
//
//  Created by Andrew Copp on 12/1/17.
//  Copyright © 2017 Andrew Copp. All rights reserved.
//

import Foundation
import CoreData

class ListInteractor {
    
    let coreData: CoreData
    let http: HTTP
    
    init(coreData: CoreData, http: HTTP) {
        self.coreData = coreData
        self.http = http
    }
    
    func synchronize() {
        if UserDefaults.standard.bool(forKey: "CounterSubsequentApplicationLaunch") {
            return
        }
        
        self.http.indexCounter { counters in
            let managedCounters: [ManagedCounter] = self.managedCounters()
            counters.forEach() { counter in
                if !managedCounters.contains(where: { $0.identifier == counter.identifier}) {
                    let managedCounter: ManagedCounter = NSEntityDescription.insertNewObject(forEntityName: "Counter", into: self.coreData.persistentContainer.viewContext) as! ManagedCounter
                    managedCounter.count = Int16(counter.count)
                    managedCounter.title = counter.title
                    managedCounter.identifier = Int16(counter.identifier)
                }
            }
            
            UserDefaults.standard.set(true, forKey: "CounterSubsequentApplicationLaunch")
            
            self.coreData.saveContext()
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: Notification.Name.init("CounterCountersDidUpdate"), object: nil, userInfo: nil)
            }
        }
        
        
    }
    
    func counters() -> [Counter] {
        let managedCounters: [ManagedCounter] = self.managedCounters()
        return managedCounters.map({ Counter(managedCounter: $0) })
    }
    
    func managedCounters() -> [ManagedCounter] {
        let request: NSFetchRequest = ManagedCounter.fetchRequest()
        let managedCounters: [ManagedCounter]
        do {
            managedCounters = try coreData.persistentContainer.viewContext.fetch(request)
        } catch {
            managedCounters = []
        }
        
        return managedCounters
    }
    
}
