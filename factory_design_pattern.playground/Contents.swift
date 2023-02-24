import UIKit
import PlaygroundSupport


protocol LabelFactoryProtocol {
    func createLabel(frame: CGRect, text: String, color: UIColor) -> UILabel
    func createButton(frame: CGRect, text: String, action: UIAction?) -> UIButton
}


final class ContentFactory: LabelFactoryProtocol {
    
    func createLabel(frame: CGRect, text: String, color: UIColor) -> UILabel {
        let label = UILabel()
        label.frame = frame
        label.numberOfLines = 0
        label.text = text
        label.textColor = color
        return label
    }
    
    func createButton(frame: CGRect, text: String, action: UIAction?) -> UIButton {
        let label = UIButton(type: .roundedRect, primaryAction: action)
        label.frame = frame
        label.setTitle(text, for: .normal)
        return label

    }
}


class MyViewController : UIViewController {
    
    private let contentFactory = ContentFactory()
    
    override func loadView() {
        let view = UIView()

        let label = contentFactory.createLabel(
            frame: CGRect(x: 50, y: 200, width: 320, height: 100),
            text: "Label Created With Factory Design Pattern",
            color: .black)

        let button = contentFactory.createButton(
            frame: CGRect(x: 50, y: 290, width: 320, height: 100),
            text: "Button created with factory",
            action: nil)
        
        view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(button)

        self.view = view
    }
}

PlaygroundPage.current.liveView = MyViewController()
