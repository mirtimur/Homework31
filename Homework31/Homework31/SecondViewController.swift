import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var maxSpeedLabel: UILabel!
    @IBOutlet weak var yearOfIssueLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    var carModel: Car? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carNameLabel.text =  NSLocalizedString("Name:", comment: "") + " " + (carModel?.name ?? "")
        maxSpeedLabel.text = NSLocalizedString("Max speed:", comment: "") + " " + (carModel?.maxSpeed ?? "")
        yearOfIssueLabel.text = NSLocalizedString("Year of issue:", comment: "") + " " + (carModel?.yearOfIssue ?? "")
        weightLabel.text = NSLocalizedString("Weight:", comment: "") + " " + (carModel?.weight ?? "")
    }
}
