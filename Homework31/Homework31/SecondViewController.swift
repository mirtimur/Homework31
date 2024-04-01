import UIKit

class SecondViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var maxSpeedLabel: UILabel!
    
    static let shared = SecondViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
}
