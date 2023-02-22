# Design Patterns in Swift
========================================

Hello and Welcome! The goal of this repository is to provide examples for each of the [23 Gang of Four design patterns](https://en.wikipedia.org/wiki/Design_Patterns) with real life problems

Please see [Getting Started](#getting-started) for more information on how to run the examples.

## Table of Contents

### Creational Patterns


[Factory Method](#factory-method)

* [x] [Factory Method](#-factory-method)
* [x] [Singleton](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/singleton_design_pattern.playground)
* [x] [Abstract Factory](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/abstract_design_pattern.playground)
* [x] [Builder](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/builder_design_pattern.playground)
* [ ] [Monostate]()
* [ ] [Prototype]()

### Behavioral Patterns

* [x] [Template method](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/template_method_design_pattern.playground)
* [x] [Observer](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/observer_design_pattern.playground)
* [x] [Memento]()
* [ ] [Command]()

### Structural Patterns

* [ ] [Facade]()
* [x] [Adapter](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/adapter_design_pattern.playground)
* [x] [MVC](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/mvc_design_pattern.playground)
* [ ] [Bridge]()
* [ ] [Decorator]()



## Getting Started


Factory Method
--------------

[Playground Example](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/factory_design_pattern.playground)

The Factory Method pattern is a creational design pattern that provides an interface for creating objects in a superclass, but allows subclasses to alter the type of objects that will be created. The idea behind the Factory Method pattern is to defer the creation of objects to subclasses, thus allowing for greater flexibility in the instantiation process.

In the Factory Method pattern, a creator class provides a factory method that returns a new object of a particular type. Subclasses of the creator class can override the factory method to return objects of a different type, allowing for different object creation strategies to be used in different contexts. This makes the Factory Method pattern useful in situations where the type of object that needs to be created is determined at runtime, based on user input or other environmental factors.

In Swift, the Factory Method pattern can be implemented using protocols and extensions to provide default implementations for the factory method in the superclass, and to allow subclasses to override the factory method to create objects of their choosing. The pattern can be used to create objects of any type, including custom classes, structs, and enums, and can be used in conjunction with other design patterns to provide even greater flexibility in object creation and manipulation.

### Example:

```swift
protocol LabelFactoryProtocol {
    func createLabel(frame: CGRect, text: String, color: UIColor) -> UILabel
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
}


class MyViewController : UIViewController {
    
    private let contentFactory = ContentFactory()
    
    override func loadView() {
        let view = UIView()

        let label = contentFactory.createLabel(
            frame: CGRect(x: 50, y: 200, width: 320, height: 100),
            text: "Label Created With Factory Design Pattern",
            color: .black)

        view.backgroundColor = .white
        view.addSubview(label)
    
        self.view = view
    }
}

PlaygroundPage.current.liveView = MyViewController()
```
