import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func addAlert() {
        let alert = UIAlertController(title: "New Car", message: "Add a new car", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
            guard let fields = alert.textFields, fields.count == 4 else { return }
            
            let nameToSave = fields[0].text
            let maxSpeedToSave = fields[1].text
            let weightToSave = fields[2].text
            let yearOfIssueToSave = fields[3].text
            CarsManager.shared.save(name: nameToSave ?? "", maxSpeed: maxSpeedToSave ?? "", weight: weightToSave ?? "", yearOfIssue: yearOfIssueToSave ?? "")
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()
        guard let fields = alert.textFields, fields.count == 4 else { return }
        
        fields[0].placeholder = "Name"
        fields[1].placeholder = "Max speed"
        fields[2].placeholder = "Weight"
        fields[3].placeholder = "Year of issue"
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func presentSecondViewController(carName: String) {
        let storyboard = UIStoryboard(name: "SecondViewController", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else { return }
        
        vc.modalPresentationStyle = .formSheet
        vc.carModel = CarsManager.shared.readCoreData().first {
            $0.name == carName
        }
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func plusButtonPressed(_ sender: UIButton) {
        addAlert()
    }
}
// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return CarsManager.shared.cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let car = CarsManager.shared.cars[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = car.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let row = indexPath.row
            let context = CarsManager.shared.persistentContainer.viewContext
            let deletingCar =  CarsManager.shared.cars[row]
            CarsManager.shared.cars.remove(at: row)
            context.delete(deletingCar)
            CarsManager.shared.saveContext()
            tableView.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentSecondViewController(carName: (CarsManager.shared.cars[indexPath.row].name ?? ""))
        
    }
}

