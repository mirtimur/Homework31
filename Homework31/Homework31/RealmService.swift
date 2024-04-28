import UIKit
import RealmSwift

class RealmService {
    
    let shared = RealmService()
    
    private init() { }
    
    private lazy var realm: Realm? = {
        do {
            let _realm = try Realm()
            return _realm
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }()
    
    func writeToRealm() {
        let toDoObject = ToDoEntity(name: "TODO", ownerId: "0")
        guard let realm else { return }
        
        do {
            try realm.write {
                realm.add(toDoObject)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
