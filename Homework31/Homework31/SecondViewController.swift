import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var maxSpeedLabel: UILabel!
    @IBOutlet weak var yearOfIssueLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    var carModel: Car? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carNameLabel.text = "Name: \(carModel?.name ?? "")"
        maxSpeedLabel.text = "Max speed: \(carModel?.maxSpeed ?? "") km/h"
        yearOfIssueLabel.text = "Year of issue: \(carModel?.yearOfIssue ?? "")"
        weightLabel.text = "Weight: \(carModel?.weight ?? "") kg"
    }
}
