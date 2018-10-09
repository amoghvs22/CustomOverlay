import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var customView: CustomizeCircle!
    @IBOutlet weak var counterLabel: UILabel!
    
    var repeatFuncTimer:Timer?
    var buttonPressStartTime: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        counterLabel.text = String(customView.angle)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(_ button: CustomButton) {
        buttonPressStartTime = Date()
        if button.isAddButton {
            
            incrementRadius()
            repeatFuncTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(incrementRadius), userInfo: nil, repeats: true)
        } else {
            decrementRadius()
            repeatFuncTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(decrementRadius), userInfo: nil, repeats: true)
        }
        
    }
    
    @IBAction func incDecRadiusButtonUp(_ button: CustomButton) {
        if let timer = repeatFuncTimer {
            timer.invalidate()
        }
        if button.isAddButton {
            incrementRadius()
        }
        else {
            decrementRadius()
        }
    }
    
    @objc func incrementRadius() {
        customView.angle += 1
        counterLabel.text = String(customView.angle)
    }
    
    @objc func decrementRadius() {
        if customView.angle > 0 {
            customView.angle -= 1
        }
        counterLabel.text = String(customView.angle)
    }
    
    
}

