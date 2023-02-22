# Design Patterns in Swift
========================================

Hello and Welcome! The goal of this repository is to provide examples for each of the [23 Gang of Four design patterns](https://en.wikipedia.org/wiki/Design_Patterns) with real life problems

Please see [Getting Started](#getting-started) for more information on how to run the examples.

## Table of Contents

### Creational Patterns

* [x] [Factory Method](#factory-method)
* [x] [Singleton](#singleton)
* [x] [Abstract Factory](#abstract-factory)
* [x] [Builder](#builder)
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

[Abstract Factory](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/abstract_design_pattern.playground)

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
---------

[Builder](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/builder_design_pattern.playground)

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

Example
---------

[Example](link)

```swift

```
