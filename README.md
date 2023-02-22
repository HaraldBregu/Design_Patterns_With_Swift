# Design Patterns in Swift
========================================

Hello and Welcome! The goal of this repository is to provide examples for each of the [23 Gang of Four design patterns](https://en.wikipedia.org/wiki/Design_Patterns) with real life problems

Please see [Getting Started](#getting-started) for more information on how to run the examples.

## Table of Contents

### [Creational Patterns](#creational-patterns)

* [x] [Factory Method](#factory-method)
* [x] [Singleton](#singleton)
* [x] [Abstract Factory](#abstract-factory)
* [x] [Builder](#builder)
* [x] [Monostate](#monostate)
* [ ] [Prototype](#prototype)

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

Creational Patterns
===================

Creational design patterns are a set of design patterns that deal with object creation mechanisms, trying to create objects in a manner suitable to the situation. These patterns aim to provide solutions to common problems related to object creation and initialization, such as controlling the creation process, hiding the complexity of object creation, and providing flexible ways to create objects.

Creational patterns typically involve creating objects in a way that promotes flexibility and reuse, while also ensuring that objects are created in a consistent and safe manner. These patterns can be used to manage complex object hierarchies, to abstract away the details of object creation, or to create objects based on specific conditions or criteria.

Some commonly used creational design patterns include the Singleton pattern, which ensures that only one instance of a class is created, the Factory pattern, which provides a way to create objects without specifying their exact class, and the Builder pattern, which provides a flexible way to create complex objects step-by-step.

Overall, creational design patterns can help to improve the organization, maintainability, and flexibility of code by providing a set of proven solutions to common problems related to object creation and initialization.

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

Singleton
---------

[Playground Example](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/singleton_design_pattern.playground)

The Singleton pattern is a creational design pattern that ensures a class has only one instance and provides a global point of access to that instance. The Singleton pattern is useful when you need to restrict the instantiation of a class to a single object, and when you need to access that object from multiple parts of your code.

In Swift, the Singleton pattern can be implemented by defining a class with a private initializer and a private static instance variable. The instance variable is initialized only once, the first time it is accessed, and is thereafter returned whenever the Singleton instance is requested. The Singleton instance can be accessed using a public static method or property.

Swift's lazy initialization feature can also be used to implement the Singleton pattern, where the instance variable is declared with the lazy keyword and the initializer is only called the first time the variable is accessed.

It is important to note that while the Singleton pattern can be useful in certain situations, it should be used judiciously as it can create global state which can make code difficult to reason about and maintain. It is generally recommended to use dependency injection and other techniques to manage object lifetimes whenever possible.

```swift

final class Sun {
    static let shared = Sun()
    var dimension: Double!
    
    private init() {}
}

var sun = Sun.shared
sun.dimension = 345
print(sun.dimension ?? "")

var sameSun = Sun.shared
print(sameSun.dimension ?? "")
sameSun.dimension = 56
print(sameSun.dimension ?? "")

```

Abstract Factory
----------------

[Playground Example](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/abstract_design_pattern.playground)

The Abstract Factory design pattern is a creational pattern that provides an interface for creating families of related or dependent objects without specifying their concrete classes. This pattern promotes loose coupling between objects by allowing the client to work with abstract interfaces instead of concrete classes.

In Swift, the Abstract Factory pattern can be implemented using a protocol that defines the abstract interface for creating related objects. Concrete factory classes can then be created to implement this protocol and provide specific implementations of the abstract interface. The client code can then work with the abstract interface and be decoupled from the concrete classes.

The Abstract Factory pattern can be useful in situations where there are families of related or dependent objects that need to be created, and the specific implementation of these objects can vary based on the context. The pattern can help to improve the flexibility, maintainability, and scalability of the code by promoting loose coupling between objects and allowing for easy substitution of concrete implementations.

```swift
protocol Garage {
    func createCar() -> Car?
    func createMotorcycle() -> Motorcycle?
}

protocol Car {
    var type: String { get set }
    func start()
}

protocol Motorcycle {
    var type: String { get set }
    func start()
}

class MotorMagazine: Garage {
    
    func createCar() -> Car? {
        return SportsCar(type: "Ferrari")
    }
    
    func createMotorcycle() -> Motorcycle? {
        return SportsMotorcycle(type: "Yamaha")
    }
    
}

private struct SportsCar: Car {
    var type: String
    
    func start() {
        print("Starting a \(type) car")
    }
}

private struct SportsMotorcycle: Motorcycle {
    var type: String
    
    func start() {
        print("Starting a \(type) motorcycle")
    }
}

class MyGarage: Garage {
    
    func createCar() -> Car? {
        return MyFavoriteCar(type: "Mercedes")
    }
    
    func createMotorcycle() -> Motorcycle? {
        return MyFavoriteMotorcycle(type: "Honda CBR")
    }

}

private struct MyFavoriteCar: Car {
    var type: String
    
    func start() {
        print("I like to drive my \(type)")
    }
}

private struct MyFavoriteMotorcycle: Motorcycle {
    var type: String
    
    func start() {
        print("I like to drive fast with my \(type)")

    }
}

let motorMagazine = MotorMagazine()
motorMagazine.createCar()?.start()
motorMagazine.createMotorcycle()?.start()

let myGarage = MyGarage()
myGarage.createCar()?.start()
myGarage.createMotorcycle()?.start()

```

Builder
-------

[Playground Example](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/builder_design_pattern.playground)

The Builder design pattern is a creational pattern that provides a flexible and step-by-step approach to creating complex objects. The pattern separates the construction of an object from its representation, allowing for different representations to be created using the same construction process.

In Swift, the Builder pattern can be implemented using a separate builder class that is responsible for constructing the object, and a director class that coordinates the construction process. The builder class can have methods for setting different properties of the object being constructed, while the director class orchestrates the order in which the builder methods are called.

The Builder pattern can be useful in situations where objects have complex initialization requirements or when there are multiple ways to represent the same object. By separating the construction process from the representation, the pattern allows for more flexibility and maintainability in the code.

```swift
enum HouseType {
    case home
    case villa
}

struct House {
    var type: HouseType!
    var garden: Garden!
    var pool: Pool!
    var plants:[Plant]!
    
    init() {}
}

struct Garden {
    var length: Double
    var width: Double
}

struct Pool {
    var length: Double
    var width: Double
}

enum PlantType {
    case tree
    case flower
}

struct Plant {
    var type: PlantType
}

class HouseBuilder {
    var house = House()
    
    static func create() -> HouseBuilder {
        let houseBuilder = HouseBuilder()
        
        return houseBuilder
    }
    
    func setType(type: HouseType) -> HouseBuilder {
        house.type = type
        
        return self
    }
    
    func add(garden: Garden) -> HouseBuilder{
        house.garden = garden

        return self
    }
    
    func add(pool: Pool) -> HouseBuilder {
        house.pool = pool
        
        return self
    }
    
    func add(plants: [Plant]) -> HouseBuilder {
        house.plants = plants
        
        return self
    }
    
    func printFullHouse() -> HouseBuilder {
        switch house.type {
        case .home:
            print("House type is home")
        case .villa:
            print("House type is villa")
        default:
            print("-")
        }
        print("garden width: \(house.garden.width) - length: \(house.garden.length)")
        print("pool width: \(house.pool.width) - length: \(house.pool.length)")
        print("plants count: \(house.plants.count)")

        return self
    }
}

/// Here is the builder
HouseBuilder.create()
    .setType(type: HouseType.villa)
    .add(garden: Garden(length: 123, width: 450))
    .add(pool: Pool(length: 87, width: 65))
    .add(plants: [
        Plant(type: PlantType.tree),
        Plant(type: PlantType.tree),
        Plant(type: PlantType.flower),
    ])
    .printFullHouse()

```

Monostate
---------

[Playground Example](link)

The Monostate design pattern is a creational pattern that ensures that all instances of a class share the same state, while still allowing for multiple instances to be created. This pattern is also known as the "Singleton with a twist" pattern, as it provides similar functionality to the Singleton pattern, but with a different approach to maintaining a shared state.

In Swift, the Monostate pattern can be implemented using a private static variable that holds the shared state of the class. All instances of the class access and modify this shared state variable, resulting in all instances sharing the same state.

The Monostate pattern can be useful in situations where multiple instances of a class need to share the same state, but where using the Singleton pattern is not appropriate. For example, the Monostate pattern can be useful in situations where the number of instances of a class needs to be dynamic, but where all instances should have the same behavior and state. However, it's important to use the pattern judiciously, as it can introduce global state and tight coupling between objects, which can make the code harder to test and maintain.

```swift
class EuropeUnion {
    private static var sharedState: String = "Normal activity"
    
    var state: String {
        get { return EuropeUnion.sharedState }
        set { EuropeUnion.sharedState = newValue }
    }
    
    func doSomething() {
        print("Doing something with state: \(state)")
    }
}

let ueInstance = EuropeUnion()
ueInstance.state = "Lockdown due to Covid-19"

let ueInstance2 = EuropeUnion()
print(ueInstance2.state)

ueInstance2.doSomething()

// Subclasses share the same state
class Germany: EuropeUnion {}
let germanyInstance = Germany()
print(germanyInstance.state)

// Subclasses share the same state
class Italy: EuropeUnion {}
let italyInstance = Italy()
print(italyInstance.state)
```

Prototype
---------

[Playground Example](link)

The Prototype design pattern is a creational pattern that allows for the creation of new objects by copying or cloning existing objects. This pattern can be useful in situations where creating new objects from scratch is expensive or time-consuming, or where objects need to be customized with different configurations or properties.

In Swift, the Prototype pattern can be implemented using a protocol that defines the interface for cloning an object. Each concrete class that implements this protocol can define its own cloning behavior, which can be customized to create new objects with different configurations or properties.

The Prototype pattern can be useful in situations where there is a need to create many similar objects, or where objects need to be customized at runtime. The pattern can help to improve the efficiency and flexibility of the code by reducing the amount of code duplication and enabling easy customization of objects.

```swift
protocol Prototype {
    func clone() -> Prototype
}

class Sheep: Prototype {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func clone() -> Prototype {
        return Sheep(name: self.name)
    }
    
}

// Example usage
let originalSheep = Sheep(name: "Maria")
let clonedSheep = originalSheep.clone() as! Sheep

print(originalSheep.name) // Prints "Maria"
print(clonedSheep.name) // Prints "Maria"

clonedSheep.name = "Dolly"

print(originalSheep.name) // Prints "John"
print(clonedSheep.name) // Prints "Jane"
```

Example
---------

[Example](link)

```swift

```
Example
---------

[Example](link)

```swift

```





Behavioral
==========

Behavioral design patterns are a set of design patterns that focus on communication between objects, encapsulating behavior in objects, and delegating responsibility among objects to achieve more flexible and reusable code. These patterns are concerned with the interactions between objects and how they work together to accomplish specific tasks or goals.

Behavioral patterns provide solutions to common problems related to managing object behavior, such as managing the flow of control between objects, managing object communication and messaging, and maintaining object state. They can also help to reduce coupling between objects, making it easier to change and maintain code over time.

Some commonly used behavioral design patterns include the Observer pattern, which defines a one-to-many dependency between objects, the Command pattern, which encapsulates a request as an object, and the Strategy pattern, which encapsulates an algorithm in an object and allows it to be swapped out at runtime.

Overall, behavioral design patterns can help to improve the organization, flexibility, and maintainability of code by providing a set of proven solutions to common problems related to object behavior.
