//
//  ManagedCounter+CoreDataProperties.swift
//  
//
//  Created by Andrew Copp on 11/30/17.
//
//

import Foundation
import CoreData


extension ManagedCounter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedCounter> {
        return NSFetchRequest<ManagedCounter>(entityName: "Counter")
    }

    @NSManaged public var count: Int16

}
