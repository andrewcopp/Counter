//
//  ManagedCounter+CoreDataProperties.swift
//  
//
//  Created by Andrew Copp on 12/1/17.
//
//

import Foundation
import CoreData


extension ManagedCounter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedCounter> {
        return NSFetchRequest<ManagedCounter>(entityName: "Counter")
    }

    @NSManaged public var count: Int16
    @NSManaged public var title: String?
    @NSManaged public var identifier: Int16

}
