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
    
    init(coreData: CoreData) {
        self.coreData = coreData
    }
    
    func counters() -> [Counter] {
        let managedCounters: [ManagedCounter] = self.managedCounter()
        return managedCounters.map({ Counter(managedCounter: $0) })
    }
    
    func managedCounter() -> [ManagedCounter] {
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
