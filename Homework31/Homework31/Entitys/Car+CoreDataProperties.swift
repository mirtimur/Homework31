import Foundation
import CoreData


extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var name: String?
    @NSManaged public var maxSpeed: String?
    @NSManaged public var weight: String?
    @NSManaged public var yearOfIssue: String?
}

extension Car : Identifiable {

}
