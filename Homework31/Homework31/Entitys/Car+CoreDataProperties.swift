//
//  Car+CoreDataProperties.swift
//  Homework31
//
//  Created by Timur Mir on 29.03.24.
//
//

import Foundation
import CoreData


extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var name: String?
    @NSManaged public var maxSpeed: String?

}

extension Car : Identifiable {

}
