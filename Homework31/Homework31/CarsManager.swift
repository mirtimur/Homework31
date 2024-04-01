import CoreData
import UIKit

class CarsManager {
    
    private init() {}
    
    static let shared = CarsManager()
    
    lazy var cars: [Car] = {
        let managedContext = self.persistentContainer.viewContext
        guard let results = try? managedContext.fetch(NSFetchRequest(entityName: "Car")) as? [Car] else { return [] }
        
        return results
    }()
    
    func save(name: String, maxSpeed: String) {
        let managedContext = self.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Car", in: managedContext) else { return }
        
        let car = Car(entity: entity, insertInto: managedContext)
        car.name = name
        car.maxSpeed = maxSpeed
        saveContext()
        cars.append(car)
        
        //print("\(try! persistentContainer.viewContext.fetch(NSFetchRequest(entityName: "Car")) as! [NSManagedObject])")
    }
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Homework31")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = self.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    // MARK: - Core delete support
    func deleteCoreData() {
        let context = self.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Car")
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                context.delete(result)
            }
        } catch {
            print(error)
        }
        self.saveContext()
    }
    
    func readCoreData() {
            let context = self.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Car")
            do {
                let results = try context.fetch(fetchRequest)
                for result in results as! [NSManagedObject] {
                    guard let resultObject = result as? Car else { return }
                    
//                    SecondViewController.shared.carNameLabel.text = resultObject.name
//                    SecondViewController.shared.maxSpeedLabel.text = resultObject.maxSpeed
                    print("name - \(resultObject.name ?? "")")
                    print("max speed - \(resultObject.maxSpeed ?? "")")
                }
            } catch {
                print(error)
            }
    }
}
