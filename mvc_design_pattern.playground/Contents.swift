//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

/// MODEL
struct Car {
    let model: String, color: UIColor
}

///CONTROLLER
class MyViewController : UIViewController {
    
    override func loadView() {
        let view = UIView()

        /// MODEL
        let car = Car(model: "BMW Series 3", color: UIColor.blue)

        /// VIEW
        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = car.model
        label.textColor = .white
        
        view.backgroundColor = car.color
        view.addSubview(label)
    
        self.view = view
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
