# Design Patterns in Swift
========================================

Hello and Welcome! 
The goal of this repository is to provide examples for each of the [23 Gang of Four design patterns](https://en.wikipedia.org/wiki/Design_Patterns) +1 with real world examples.

Programming design patterns are commonly used solutions to recurring problems in software development. They are tried and tested approaches that have been refined over time to help developers write efficient, reliable, and maintainable code. These patterns encapsulate best practices and provide a way for developers to structure their code in a way that is both organized and understandable. By using design patterns, developers can improve the quality of their code and reduce the time and effort required to create new software. Understanding and using programming design patterns is an essential skill for any software developer looking to create robust and scalable applications.

## Classification

### [Creational Patterns](#creational-design-patterns)

* [x] Factory Method
* [x] Singleton
* [x] Abstract Factory
* [x] Builder
* [x] Monostate
* [x] Prototype

### [Behavioral Patterns](#behavioral-design-patterns)

* [x] Template method
* [x] Observer
* [x] Memento
* [x] Command
* [x] Chain Of Responsibility
* [x] Interpreter
* [x] Iterator
* [x] Mediator
* [x] State  
* [x] Strategy       
* [x] Visitor

### [Structural Patterns](#structural-design-patterns)

* [x] Adapter
* [x] Bridge
* [x] Composite  
* [x] Decorator
* [x] Façade
* [x] Flyweight
* [x] Proxy


Creational Design Patterns
===================

Creational design patterns are a set of design patterns that deal with object creation mechanisms, trying to create objects in a manner suitable to the situation. These patterns aim to provide solutions to common problems related to object creation and initialization, such as controlling the creation process, hiding the complexity of object creation, and providing flexible ways to create objects.

Creational patterns typically involve creating objects in a way that promotes flexibility and reuse, while also ensuring that objects are created in a consistent and safe manner. These patterns can be used to manage complex object hierarchies, to abstract away the details of object creation, or to create objects based on specific conditions or criteria.

Some commonly used creational design patterns include the Singleton pattern, which ensures that only one instance of a class is created, the Factory pattern, which provides a way to create objects without specifying their exact class, and the Builder pattern, which provides a flexible way to create complex objects step-by-step.

Overall, creational design patterns can help to improve the organization, maintainability, and flexibility of code by providing a set of proven solutions to common problems related to object creation and initialization.

* [Factory Method](#factory-method)
* [Singleton](#singleton)
* [Abstract Factory](#abstract-factory)
* [Builder](#builder)
* [Monostate](#monostate)
* [Prototype](#prototype)

Factory Method
--------------

[Playground Example](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/factory_design_pattern.playground)

The Factory Method pattern is a creational design pattern that provides an interface for creating objects in a superclass, but allows subclasses to alter the type of objects that will be created. The idea behind the Factory Method pattern is to defer the creation of objects to subclasses, thus allowing for greater flexibility in the instantiation process.

In the Factory Method pattern, a creator class provides a factory method that returns a new object of a particular type. Subclasses of the creator class can override the factory method to return objects of a different type, allowing for different object creation strategies to be used in different contexts. This makes the Factory Method pattern useful in situations where the type of object that needs to be created is determined at runtime, based on user input or other environmental factors.

In Swift, the Factory Method pattern can be implemented using protocols and extensions to provide default implementations for the factory method in the superclass, and to allow subclasses to override the factory method to create objects of their choosing. The pattern can be used to create objects of any type, including custom classes, structs, and enums, and can be used in conjunction with other design patterns to provide even greater flexibility in object creation and manipulation.

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
------------

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
----------

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
------------

[Playground Example](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/monostate_design_pattern.playground)

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

[Playground Example](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/prototype_design_pattern.playground)

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

print(originalSheep.name) // Prints "Maria"
print(clonedSheep.name) // Prints "Dolly"
```


Behavioral Design Patterns
===================

Behavioral design patterns are a set of design patterns that focus on communication between objects, encapsulating behavior in objects, and delegating responsibility among objects to achieve more flexible and reusable code. These patterns are concerned with the interactions between objects and how they work together to accomplish specific tasks or goals.

Behavioral patterns provide solutions to common problems related to managing object behavior, such as managing the flow of control between objects, managing object communication and messaging, and maintaining object state. They can also help to reduce coupling between objects, making it easier to change and maintain code over time.

Some commonly used behavioral design patterns include the Observer pattern, which defines a one-to-many dependency between objects, the Command pattern, which encapsulates a request as an object, and the Strategy pattern, which encapsulates an algorithm in an object and allows it to be swapped out at runtime.

Overall, behavioral design patterns can help to improve the organization, flexibility, and maintainability of code by providing a set of proven solutions to common problems related to object behavior.

* [Template method](#template-method)
* [Observer](#observer)
* [Memento](#memento)
* [Command](#command)
* [Chain Of Responsibility](#chain-of-responsibility)
* [Interpreter](#interpreter)   
* [Iterator](#iterator)   
* [Mediator](#mediator)
* [State](#state)  
* [Strategy](#strategy)            
* [Visitor](#visitor)  

Template method
---------------

[Playground Example](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/template_method_design_pattern.playground)

The Template Method design pattern is a behavioral pattern that defines the skeleton of an algorithm in a base class but allows subclasses to override specific steps of the algorithm without changing its structure. It is used when multiple algorithms have similar steps but may differ in their implementation.

In Swift, the Template Method pattern can be implemented using a base class that defines a common algorithm, with certain steps marked as abstract methods or placeholders to be implemented by subclasses. The concrete subclasses then provide their own implementation for these abstract methods or placeholders to customize the algorithm according to their specific needs. This allows for code reuse and consistency in algorithm structure while still allowing for flexibility and customization.

```swift
protocol Administration {
    var postOfficeName: String { get }
    var superMarketName: String { get }
    func show()
}

extension Administration {
    
    var postOfficeName: String {
        return "The Central Office"
    }
   
    var superMarketName: String {
        return "LIDL"
    }
    
    func show() {
        print("My city had a post office name: \(postOfficeName) and a supermarket with name: \(superMarketName)")
    }

}

class City: Administration {

    init() {
        show()
    }
    
}

City()
```

Observer
--------

[Playground Example](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/observer_design_pattern.playground)

The Observer design pattern is a behavioral pattern that allows objects to be notified and updated when a change occurs in the state of another object. It is used to establish a one-to-many relationship between objects, where changes in one object are automatically propagated to other objects that depend on it.

In Swift, the Observer pattern can be implemented using a subject (also known as the observable) that maintains a list of observers (also known as listeners) and notifies them when its state changes. Observers can then respond to these notifications and update their state or perform other actions as needed. This allows for loose coupling between objects and promotes separation of concerns, making it easier to maintain and extend the codebase over time.

```swift
protocol Observer: AnyObject {
    func update()
}

class Subject {
    var observers = [Observer]()
    var state: Int = 0 {
        didSet {
            notifyObservers()
        }
    }
    
    func attach(_ observer: Observer) {
        observers.append(observer)
    }
    
    func detach(_ observer: Observer) {
        if let index = observers.firstIndex(where: { $0 === observer }) {
            observers.remove(at: index)
        }
    }
    
    func notifyObservers() {
        for observer in observers {
            observer.update()
        }
    }
}

class ConcreteObserver: Observer {
    var name: String
    weak var subject: Subject?
    
    init(name: String, subject: Subject) {
        self.name = name
        self.subject = subject
        subject.attach(self)
    }
    
    func update() {
        if let state = subject?.state {
            print("\(name) received update with new state: \(state)")
        }
    }
    
    deinit {
        subject?.detach(self)
    }
}

let subject = Subject()
let observer1 = ConcreteObserver(name: "Observer 1", subject: subject)
let observer2 = ConcreteObserver(name: "Observer 2", subject: subject)

subject.state = 1
// Output:
// Observer 1 received update with new state: 1
// Observer 2 received update with new state: 1

subject.state = 2
// Output:
// Observer 1 received update with new state: 2
// Observer 2 received update with new state: 2
```

Memento
---------

[Playground Example](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/memento_design_pattern.playground)

The Memento design pattern is a behavioral pattern that allows an object to capture its internal state and save it externally so that it can be restored later without violating encapsulation. It is used when an object needs to be able to save and restore its state, such as for undo/redo functionality or for checkpointing.

In Swift, the Memento pattern can be implemented using three components: the Originator, the Memento, and the Caretaker. The Originator is the object whose state needs to be saved and restored. It creates and stores Memento objects that capture its state at a particular point in time. The Caretaker is responsible for managing the Memento objects, storing them in a history or undo/redo stack, and restoring the Originator's state as needed using the Memento objects. This allows for efficient and flexible state management, as well as for the separation of concerns between objects that need to save state and those that need to manage it.

```swift
protocol ActivityMemento {
    var name: String { get }
}

class ConcreteActivityMemento: ActivityMemento {
    
    private(set) var state: String

    init(state: String) {
        self.state = state
    }
    
    var name: String {
        return state
    }
    
}

class HumanOriginator {
    
    private var state: String

    init(state: String) {
        self.state = state
    }

    func doSomething(_ action: String) {
        state = action
    }

    func save() -> ActivityMemento {
        return ConcreteActivityMemento(state: state)
    }
        
    func restore(memento: ActivityMemento) {
        guard let memento = memento as? ConcreteActivityMemento else { return }
        self.state = memento.state
    }
    
}

class Caretaker {

    private lazy var mementos = [ActivityMemento]()
    
    private var originator: HumanOriginator

    init(originator: HumanOriginator) {
        self.originator = originator
    }

    func backup() {
        mementos.append(originator.save())
    }

    func undo() {

        guard !mementos.isEmpty else { return }
        let removedMemento = mementos.removeLast()
        originator.restore(memento: removedMemento)
    }

    func showHistory() {
        mementos.forEach({ print($0.name) })
    }
}

let originator = HumanOriginator(state: "1. I took a walk")
let caretaker = Caretaker(originator: originator)

/// Saving initial state
caretaker.backup()

// Save another state
originator.doSomething("2. I went for a run")
caretaker.backup()

// Save another state
originator.doSomething("3. I went to play soccer/football")
caretaker.backup()

// Save another state
originator.doSomething("4. I went to sleep")
caretaker.backup()

print("\nCaretaker: Here's the list of mementos:\n")
caretaker.showHistory()

print("\nUndo one object\n")
caretaker.undo()
caretaker.showHistory()

print("\nUndo one object\n")
caretaker.undo()
caretaker.showHistory()

print("\nUndo one object\n")
caretaker.undo()
caretaker.showHistory()
```

Command
---------

[Playground Example](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/command_design_pattern.playground)

The Command pattern is a behavioral design pattern that encapsulates a request as an object, thereby allowing for the parameterization of clients with different requests, queue or log requests, and support undoable operations.

In Swift, the Command pattern can be implemented using a protocol that defines the interface for all commands, and a concrete class for each command. The concrete classes implement the interface defined by the protocol, and encapsulate the necessary information and logic to execute the command.

```swift
protocol Command {
    func run()
}

class CarCommand: Command {
    
    private var payload: String

    init(_ payload: String) {
        self.payload = payload
    }

    func run() {
        print(payload)
    }
}

class SpaceshipCommand: Command {

    private var receiver: Receiver

    private var a: String
    private var b: String

    init(_ receiver: Receiver, _ a: String, _ b: String) {
        self.receiver = receiver
        self.a = a
        self.b = b
    }

    func run() {
        print("SpaceshipCommand: Complex operations should be done by a receiver object.\n")
        receiver.doSomething(a)
        receiver.doSomethingElse(b)
    }
}

class Receiver {

    func doSomething(_ a: String) {
        print("Receiver: " + a)
    }

    func doSomethingElse(_ b: String) {
        print("Receiver: " + b)
    }
    
}

class Invoker {
    private var onStart: Command?
    private var onFinish: Command?

    func setOnStart(_ command: Command) {
        onStart = command
    }

    func setOnFinish(_ command: Command) {
        onFinish = command
    }

    func doSomethingImportant() {

        print("Operations before start:")
        onStart?.run()
        print("\n")

        print("Operations before finish:")
        onFinish?.run()
        print("\n")

        print("Operations finished\n")
    }
}

let invoker = Invoker()
invoker.setOnStart(CarCommand("Turn on the engine"))
//invoker.setOnFinish(CarCommand("Turn off the engine"))

let receiver = Receiver()
invoker.setOnFinish(SpaceshipCommand(receiver, "Turn on the engines", "Take Off"))

invoker.doSomethingImportant()
```

Chain Of Responsibility
-----------------------

[Playground Example](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/chain_of_responsibility_design_pattern.playground)

The Chain of Responsibility pattern is a behavioral design pattern that allows you to pass requests along a chain of objects until one of the objects handles the request. In Swift, the Chain of Responsibility pattern is often used to manage a series of loosely-coupled objects, each of which can handle a specific type of request.


```swift
protocol Handler: AnyObject {

    @discardableResult
    func setNext(handler: Handler) -> Handler

    func handle(request: String) -> String?

    var nextHandler: Handler? { get set }
}

extension Handler {

    func setNext(handler: Handler) -> Handler {
        self.nextHandler = handler
        return handler
    }

    func handle(request: String) -> String? {
        return nextHandler?.handle(request: request)
    }
}

class DoorHandler: Handler {
    
    var nextHandler: Handler?
    
    func handle(request: String) -> String? {
        if request == "OPEN_THE_DOOR" {
            return "Task: " + request
        }
        return nextHandler?.handle(request: request)
    }
}


class TVHandler: Handler {
    
    var nextHandler: Handler?
    
    func handle(request: String) -> String? {
        if request == "TURN_ON_THE_TV" {
            return "Task: " + request
        }
        return nextHandler?.handle(request: request)
    }
}



class MonkeyHandler: Handler {

    var nextHandler: Handler?

    func handle(request: String) -> String? {
        if (request == "Banana") {
            return "Monkey: I'll eat the " + request + ".\n"
        } else {
            return nextHandler?.handle(request: request)
        }
    }
}

class SquirrelHandler: Handler {

    var nextHandler: Handler?

    func handle(request: String) -> String? {
        if (request == "Nut") {
            return "Squirrel: I'll eat the " + request + ".\n"
        } else {
            return nextHandler?.handle(request: request)
        }
    }
}

class DogHandler: Handler {

    var nextHandler: Handler?

    func handle(request: String) -> String? {
        if (request == "MeatBall") {
            return "Dog: I'll eat the " + request + ".\n"
        } else {
            return nextHandler?.handle(request: request)
        }
    }
}



class Client {

    static func someClientCode(handler: Handler) {

        let food = ["Nut", "Banana", "Cup of coffee"]

        food.forEach { item in
            
            print("Client: Who wants a " + item + "?\n")

            guard let result = handler.handle(request: item) else {
                print("  " + item + " was left untouched.\n")
                return
            }

            print("  " + result)
        }
        
    }
}

let door = DoorHandler()
let tv = TVHandler()
door.setNext(handler: tv)

let operations = ["OPEN_THE_DOOR", "TURN_ON_THE_TV"]

operations.forEach { item in
    
    print("USER WANTS TO " + item + "?\n")

    guard let result = door.handle(request: item) else {
        print("  " + item + " operation didn't started.\n")
        return
    }

    print("  " + result)
}

```

Interpreter
-----------

[Playground Example](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/interpreter_design_pattern.playground)

The Interpreter design pattern in Swift is a behavioral pattern that is used to define a grammar for a language and provides a way to interpret sentences in that language. It allows you to build a language interpreter that can understand and execute a set of commands or expressions.

```swift
indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case subtraction(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
    case division(ArithmeticExpression, ArithmeticExpression)
}

class ArithmeticInterpreter {
    func interpret(_ expression: ArithmeticExpression) -> Int {
        switch expression {
        case .number(let value):
            return value
        case .addition(let left, let right):
            return interpret(left) + interpret(right)
        case .subtraction(let left, let right):
            return interpret(left) - interpret(right)
        case .multiplication(let left, let right):
            return interpret(left) * interpret(right)
        case .division(let left, let right):
            return interpret(left) / interpret(right)
        }
    }
}

let expression = ArithmeticExpression.addition(
    .number(2),
    .multiplication(
        .addition(
            .number(3),
            .number(2)
        ),
        .number(4)
    )
)

let interpreter = ArithmeticInterpreter()
let result = interpreter.interpret(expression)
print(result) // Output: 26
```

Iterator
--------

[Playground Example](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/iterator_design_pattern.playground)

The Iterator design pattern in Swift is a behavioral pattern that allows you to traverse elements of a collection (such as an array or a dictionary) without exposing the underlying representation of the collection. It provides a standardized way to access the elements of a collection and perform operations on them.

```swift
protocol Iterator {
    associatedtype Element
    func hasNext() -> Bool
    func next() -> Element?
}

class ArrayIterator<T>: Iterator {
    typealias Element = T
    
    private var currentIndex = 0
    private let elements: [Element]
    
    init(elements: [Element]) {
        self.elements = elements
    }
    
    func hasNext() -> Bool {
        return currentIndex < elements.count
    }
    
    func next() -> Element? {
        guard hasNext() else { return nil }
        defer { currentIndex += 1 }
        return elements[currentIndex]
    }
}

struct MyCollection<T> {
    private let elements: [T]
    
    init(elements: [T]) {
        self.elements = elements
    }
    
    func makeIterator() -> ArrayIterator<T> {
        return ArrayIterator(elements: elements)
    }
}

let myCollection = MyCollection(elements: [1, 2, 3, 4, 5])
var iterator = myCollection.makeIterator()

while iterator.hasNext() {
    if let element = iterator.next() {
        print(element)
    }
}
```

Mediator
--------

[Playground Example](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/mediator_design_pattern.playground)

The Mediator design pattern is a behavioral pattern that allows objects to communicate with each other through a mediator object instead of directly interacting with each other. The mediator object encapsulates the communication logic between objects, reducing their coupling and making it easier to maintain and modify the system. This pattern promotes loose coupling and simplifies the interaction between objects by centralizing the communication logic into a single mediator object. In Swift, this pattern can be implemented using a mediator protocol that defines the communication interface and concrete mediator objects that implement the protocol and handle the actual communication between objects.

```swift
protocol Mediator {
    func send(message: String, sender: Colleague)
}

class ConcreteMediator: Mediator {
    private var colleagues = [Colleague]()

    func register(colleague: Colleague) {
        colleagues.append(colleague)
    }

    func send(message: String, sender: Colleague) {
        for colleague in colleagues where colleague !== sender {
            colleague.receive(message: message)
        }
    }
}

class Colleague {
    var mediator: Mediator
    
    init(mediator: Mediator) {
        self.mediator = mediator
    }

    func send(message: String) {
        mediator.send(message: message, sender: self)
    }
    
    func receive(message: String) {
        print("Received message: \(message)")
    }
}

class ConcreteColleagueA: Colleague {
    override func send(message: String) {
        print("Sending message: \(message)")
        super.send(message: message)
    }
}

class ConcreteColleagueB: Colleague {
    override func send(message: String) {
        print("Sending message: \(message)")
        super.send(message: message)
    }
}

let mediator = ConcreteMediator()
let colleagueA = ConcreteColleagueA(mediator: mediator)
let colleagueB = ConcreteColleagueB(mediator: mediator)

mediator.register(colleague: colleagueA)
mediator.register(colleague: colleagueB)

colleagueA.send(message: "Hello from colleague A!")
colleagueB.send(message: "Hi there from colleague B!")
```

State
-----

[Playground Example](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/state_design_pattern.playground)

The State design pattern allows an object to alter its behavior when its internal state changes. It encapsulates the logic for each state into separate classes and allows the object to delegate to the current state class for behavior changes. This pattern is useful when an object's behavior needs to vary based on its internal state and when there are multiple states that the object can be in.

In this pattern, the object that is being changed is known as the "context" and the different states it can be in are represented by "state" objects. The context delegates to the current state object for behavior changes, and can change its state by switching to a different state object.

The State pattern promotes loose coupling between the context and the state objects, as each state encapsulates its own behavior and can be swapped out at runtime. This promotes maintainability and extensibility of the codebase.

```swift
protocol State {
    func pressButton(context: Context)
}

class Context {
    private var state: State
    
    init(state: State) {
        self.state = state
    }
    
    func setState(state: State) {
        self.state = state
    }
    
    func pressButton() {
        self.state.pressButton(context: self)
    }
}

class ConcreteStateA: State {
    
    func pressButton(context: Context) {
        print("State is A. Pressing button changes state to B.")
        context.setState(state: ConcreteStateB())
    }
}

class ConcreteStateB: State {
    
    func pressButton(context: Context) {
        print("State is B. Pressing button changes state back to A.")
        context.setState(state: ConcreteStateA())
    }
}

let context = Context(state: ConcreteStateA())
context.pressButton() // Output: "State is A. Pressing button changes state to B."
context.pressButton() // Output: "State is B. Pressing button changes state back to A."
```

Strategy
--------

[Playground Example](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/strategy_design_pattern.playground)

The Strategy design pattern is a behavioral pattern that allows you to define a family of algorithms, encapsulate each one as an object, and make them interchangeable. It lets the algorithm vary independently from clients that use it.

In Swift, you can define a Strategy interface or protocol that declares the methods or properties that all concrete strategies must implement. You can then create concrete strategy classes that conform to the protocol and implement the algorithm specific to that strategy. Finally, you can use the strategies in a client class or function that takes a strategy object as a parameter and uses it to execute the algorithm.

This pattern is useful when you need to provide multiple variations of an algorithm, or when you want to switch between different algorithms at runtime without changing the code that uses them.

```swift
protocol Strategy {
    func execute(_ data: [Int]) -> [Int]
}

class BubbleSortStrategy: Strategy {
    func execute(_ data: [Int]) -> [Int] {
        var array = data
        for i in 0..<array.count {
            for j in 1..<array.count - i {
                if array[j] < array[j-1] {
                    let temp = array[j-1]
                    array[j-1] = array[j]
                    array[j] = temp
                }
            }
        }
        return array
    }
}

class QuickSortStrategy: Strategy {
    func execute(_ data: [Int]) -> [Int] {
        guard data.count > 1 else {
            return data
        }

        let pivot = data[data.count / 2]
        let less = data.filter { $0 < pivot }
        let equal = data.filter { $0 == pivot }
        let greater = data.filter { $0 > pivot }

        return execute(less) + equal + execute(greater)
    }
}

class Context {
    private let strategy: Strategy

    init(strategy: Strategy) {
        self.strategy = strategy
    }

    func executeStrategy(_ data: [Int]) -> [Int] {
        return strategy.execute(data)
    }
}

let data = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
let context1 = Context(strategy: BubbleSortStrategy())
let sortedData1 = context1.executeStrategy(data)
print("Sorted data using bubble sort strategy: \(sortedData1)")

let context2 = Context(strategy: QuickSortStrategy())
let sortedData2 = context2.executeStrategy(data)
print("Sorted data using quick sort strategy: \(sortedData2)")
```

Visitor
---------

[Playground Example](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/visitor_design_pattern.playground)

The Visitor pattern is a behavioral design pattern that allows adding new behaviors to an object structure without modifying the objects themselves. The pattern is based on the idea of having a separate object (the visitor) that is responsible for performing operations on the elements of an object structure. The visitor object can access and modify the elements of the object structure through a set of well-defined interfaces.

In Swift, the Visitor pattern can be implemented using protocols to define the interfaces for the visitor and the elements of the object structure. The elements of the object structure can then implement these interfaces to allow the visitor to perform operations on them. The visitor can be implemented as a separate class that conforms to the visitor protocol, and can be passed to the elements of the object structure as a parameter to their accept() method.

```swift
protocol Visitor {
    func visit(book: Book)
    func visit(movie: Movie)
}

protocol Media {
    func accept(visitor: Visitor)
}

class Book: Media {
    let title: String
    let author: String

    init(title: String, author: String) {
        self.title = title
        self.author = author
    }

    func accept(visitor: Visitor) {
        visitor.visit(book: self)
    }
}

class Movie: Media {
    let title: String
    let director: String

    init(title: String, director: String) {
        self.title = title
        self.director = director
    }

    func accept(visitor: Visitor) {
        visitor.visit(movie: self)
    }
}

class ShortSummaryVisitor: Visitor {
    func visit(book: Book) {
        print("Book: \(book.title) by \(book.author)")
    }

    func visit(movie: Movie) {
        print("Movie: \(movie.title) directed by \(movie.director)")
    }
}

class LongSummaryVisitor: Visitor {
    func visit(book: Book) {
        print("Book: \(book.title) by \(book.author). This is a great book about \(book.title).")
    }

    func visit(movie: Movie) {
        print("Movie: \(movie.title) directed by \(movie.director). This is a great movie about \(movie.title).")
    }
}

let media: [Media] = [
    Book(title: "The Catcher in the Rye", author: "J.D. Salinger"),
    Movie(title: "The Godfather", director: "Francis Ford Coppola")]

let shortSummaryVisitor = ShortSummaryVisitor()
let longSummaryVisitor = LongSummaryVisitor()

media.forEach { item in
    item.accept(visitor: shortSummaryVisitor)
    item.accept(visitor: longSummaryVisitor)
}
```

Structural Design Patterns
===================

Structural design patterns in Swift are design patterns that focus on the composition of classes and objects to form larger structures or solve problems by identifying simple ways to realize relationships between entities. The purpose of structural patterns is to provide ways to manage the relationships between objects to create larger, more complex structures with greater ease and flexibility.

* [Adapter](#adapter)
* [Bridge](#bridge)
* [Composite](#composite)  
* [Decorator](#decorator)
* [Façade](#façade)
* [Flyweight](#flyweight)
* [Proxy](#proxy)

Adapter
---------

[Playground Example](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/adapter_design_pattern.playground)

An adapter design pattern in Swift is a structural design pattern that allows incompatible interfaces to work together. It acts as a bridge between two incompatible interfaces by translating one interface into another that the client understands.

The adapter pattern involves three main components: the client, the target, and the adapter. The client is the object that needs to use the target interface, but its interface is not compatible with the target interface. The target is the object that provides the interface that the client wants to use. The adapter is the object that bridges the gap between the client and the target, by implementing the target interface and translating the requests from the client into requests that the target can understand.

In Swift, the adapter pattern can be implemented using classes, protocols, and extensions. The adapter class can conform to the target protocol and provide the necessary implementation to translate the client requests into target requests. Alternatively, the adapter can be implemented using protocol extensions that add the necessary methods to the client interface to interact with the target.


```swift
protocol Speaking {
    func speak()
}

protocol Woofing {
    func woof()
}

protocol Jumping {
    func jump()
}


class Human: Speaking, Jumping {
    
    func speak() {
        print("Humans can speak")
    }
    
    func jump() {
        print("Humans can jump")
    }
    
}

class Animal: Jumping, Woofing {
    
    func jump() {
        print("Animals can jump")
    }
    
    func woof() {
        print("Some animals can woof")
    }
    
}

let human = Human()
human.jump()
human.speak()

let animal = Animal()
animal.jump()
animal.woof()
```

Bridge
---------

[Playground Example](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/bridge_design_pattern.playground)

The Bridge design pattern in Swift is a structural pattern that allows decoupling of an abstraction from its implementation. It involves creating two separate hierarchies of classes, one for the abstraction and one for the implementation, and using composition to connect them.

In this pattern, the Abstraction defines the high-level interface that clients interact with, and the Implementation defines the low-level implementation details. The Bridge acts as a link between them and allows the Abstraction and Implementation to vary independently.

Using the Bridge pattern, you can make changes to the Abstraction or Implementation classes without affecting each other. This makes it easier to maintain and extend your codebase.

An example of the Bridge pattern in Swift could be a music player application where the Abstraction represents the user interface for playing music and the Implementation represents the platform-specific audio API. By using the Bridge pattern, you can switch between different audio APIs without having to change the user interface code.

```swift
protocol DrawAPI {
    func drawCircle(radius: Int, x: Int, y: Int)
}

class RedCircle: DrawAPI {
    func drawCircle(radius: Int, x: Int, y: Int) {
        print("Drawing Red Circle, radius: \(radius), x: \(x), y: \(y)")
    }
}

protocol Shape {
    func draw()
}

class Circle: Shape {
    let radius: Int
    let x: Int
    let y: Int
    let drawAPI: DrawAPI
    
    init(radius: Int, x: Int, y: Int, drawAPI: DrawAPI) {
        self.radius = radius
        self.x = x
        self.y = y
        self.drawAPI = drawAPI
    }
    
    func draw() {
        drawAPI.drawCircle(radius: radius, x: x, y: y)
    }
}


let redCircle = Circle(radius: 10, x: 5, y: 6, drawAPI: RedCircle())
redCircle.draw()
```

Composite
---------

[Playground Example](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/composite_design_pattern.playground)

The Composite pattern is a structural design pattern that allows you to treat a group of objects the same way as a single instance of an object. The pattern composes objects into tree-like structures to represent part-whole hierarchies. Clients can treat individual objects and compositions of objects uniformly, without knowing the difference between them.

In Swift, this pattern can be useful when dealing with hierarchies of objects such as user interfaces or file systems. The Composite pattern can help to simplify code by providing a uniform interface for working with both individual objects and groups of objects.

```swift
protocol Shape {
    func draw()
}

class Circle: Shape {
    func draw() {
        print("a circle")
    }
}

class Rectangle: Shape {
    func draw() {
        print("a rectangle")
    }
}

class Drawing: Shape {
    private var shapes = [Shape]()
    
    func add(shape: Shape) {
        shapes.append(shape)
    }
    
    func draw() {
        print("Drawing..")
        for shape in shapes {
            shape.draw()
        }
    }
}

let circle = Circle()
let rectangle = Rectangle()
let drawing = Drawing()

drawing.add(shape: circle)
drawing.add(shape: rectangle)
drawing.draw()
```

Decorator
---------

[Playground Example](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/decorator_design_pattern.playground)

The Decorator design pattern in Swift is a structural pattern that allows you to dynamically add new behaviors to an object without modifying its existing code. It involves creating a decorator class that wraps around the original object and adds new functionality to it by providing a new interface. The decorator class has the same interface as the original object, so it can be used in the same way. The decorator can also be chained together, allowing you to add multiple layers of behavior to the original object.

In essence, the Decorator pattern provides an alternative to subclassing for extending an object's behavior. Instead of creating a new subclass for every possible combination of behaviors, you can use decorators to add those behaviors dynamically at runtime.

```swift
protocol TextFormatter {
    func format(text: String) -> String
}

class PlainTextFormatter: TextFormatter {
    func format(text: String) -> String {
        return text
    }
}

class BoldTextDecorator: TextFormatter {
    private let wrappedFormatter: TextFormatter
    
    init(_ formatter: TextFormatter) {
        self.wrappedFormatter = formatter
    }
    
    func format(text: String) -> String {
        let wrappedText = wrappedFormatter.format(text: text)
        return "<b>\(wrappedText)</b>"
    }
}

class ItalicTextDecorator: TextFormatter {
    private let wrappedFormatter: TextFormatter
    
    init(_ formatter: TextFormatter) {
        self.wrappedFormatter = formatter
    }
    
    func format(text: String) -> String {
        let wrappedText = wrappedFormatter.format(text: text)
        return "<i>\(wrappedText)</i>"
    }
}

let plainText = "Hello, world!"
let plainFormatter = PlainTextFormatter()
print(plainFormatter.format(text: plainText)) // Output: Hello, world!

let boldFormatter = BoldTextDecorator(plainFormatter)
print(boldFormatter.format(text: plainText)) // Output: <b>Hello, world!</b>

let italicFormatter = ItalicTextDecorator(boldFormatter)
print(italicFormatter.format(text: plainText)) // Output: <i><b>Hello, world!</b></i>
```

Façade
---------

[Playground Example](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/facade_design_pattern.playground)

The Facade design pattern is a structural pattern that provides a simplified interface to a complex system or set of subsystems. It is used to decouple the client code from the system's complexity and to provide an easier-to-use interface for the client. The Facade pattern is often used in APIs, libraries, and frameworks to provide a simplified, high-level interface for the users of the system.

In Swift, the Facade pattern can be implemented by creating a facade class that provides a simplified interface to a set of subsystems, hiding the complexity of the underlying system. The facade class can coordinate the subsystems and provide a simplified interface for the client code to interact with.

```swift
class Car {
    func start() {
        print("Starting the car.")
    }
    
    func stop() {
        print("Stopping the car.")
    }
}

class AirConditioner {
    func turnOn() {
        print("Turning on the air conditioner.")
    }
    
    func turnOff() {
        print("Turning off the air conditioner.")
    }
}

class Radio {
    func turnOn() {
        print("Turning on the radio.")
    }
    
    func turnOff() {
        print("Turning off the radio.")
    }
    
    func setStation(_ station: String) {
        print("Setting the radio station to \(station).")
    }
}

class CarSystem {
    let car = Car()
    let airConditioner = AirConditioner()
    let radio = Radio()
    
    func startCar() {
        car.start()
        airConditioner.turnOn()
        radio.turnOn()
        radio.setStation("FM 102.5")
    }
    
    func stopCar() {
        radio.turnOff()
        airConditioner.turnOff()
        car.stop()
    }
}

// Usage
let carSystem = CarSystem()
carSystem.startCar() // Starting the car. Turning on the air conditioner. Turning on the radio. Setting the radio station to FM 100.5.
carSystem.stopCar() // Turning off the radio. Turning off the air conditioner. Stopping the
```

Flyweight
---------

[Playground Example](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/flyweight_design_pattern.playground)

The Flyweight design pattern is a structural pattern that aims to minimize memory usage by sharing data between multiple objects. This is achieved by separating the object's intrinsic state, which is unique to each object, from its extrinsic state, which is shared among objects. The intrinsic state is stored in a flyweight object, while the extrinsic state is passed as a parameter to the object's methods.

In Swift, this pattern can be useful for optimizing memory usage in situations where a large number of objects need to be created with similar properties. By sharing the intrinsic state, the number of unique objects can be minimized, which reduces memory usage and improves performance.

```swift
class Circle {
    var color: String
    
    init(color: String) {
        self.color = color
    }
    
    func draw(x: Int, y: Int, radius: Int) {
        print("Drawing circle of color \(color) at (\(x),\(y)) with radius \(radius)")
    }
}

class CircleFactory {
    var circles = [String: Circle]()
    
    func getCircle(color: String) -> Circle {
        if let circle = circles[color] {
            return circle
        } else {
            let newCircle = Circle(color: color)
            circles[color] = newCircle
            return newCircle
        }
    }
}

let circleFactory = CircleFactory()

let redCircle = circleFactory.getCircle(color: "red")
redCircle.draw(x: 10, y: 10, radius: 5)

let blueCircle = circleFactory.getCircle(color: "blue")
blueCircle.draw(x: 20, y: 20, radius: 10)

let anotherRedCircle = circleFactory.getCircle(color: "red")
anotherRedCircle.draw(x: 30, y: 30, radius: 7)
```

Proxy
---------

[Playground Example](https://github.com/HaraldBregu/design_patterns_in_swift/tree/main/proxy_design_pattern.playground)

Proxy design pattern is a structural pattern that provides a surrogate or placeholder for another object to control access to it. It allows us to create a proxy object that acts as a substitute for a real object. The proxy object intercepts all the requests made to the real object and delegates them to it as necessary, while also providing additional functionality if needed.

In Swift, the proxy pattern can be used to add extra behavior or control access to objects, such as limiting the number of requests that can be made to a resource or caching expensive computations. The proxy object usually conforms to the same protocol as the real object, ensuring that it can be used interchangeably with the original object.

```swift
protocol BankAccount {
    func deposit(amount: Double)
    func withdraw(amount: Double)
    var balance: Double { get }
}

class BankAccountImpl: BankAccount {
    private var accountBalance: Double = 0
    
    func deposit(amount: Double) {
        accountBalance += amount
        print("Deposited \(amount), account balance now \(accountBalance)")
    }
    
    func withdraw(amount: Double) {
        if accountBalance >= amount {
            accountBalance -= amount
            print("Withdrew \(amount), account balance now \(accountBalance)")
        } else {
            print("Insufficient funds")
        }
    }
    
    var balance: Double {
        return accountBalance
    }
}

class BankAccountProxy: BankAccount {
    private var realBankAccount: BankAccountImpl
    
    init() {
        realBankAccount = BankAccountImpl()
    }
    
    func deposit(amount: Double) {
        realBankAccount.deposit(amount: amount)
    }
    
    func withdraw(amount: Double) {
        realBankAccount.withdraw(amount: amount)
    }
    
    var balance: Double {
        return realBankAccount.balance
    }
}

let bankAccount: BankAccount = BankAccountProxy()
bankAccount.deposit(amount: 1000.0)
bankAccount.withdraw(amount: 500.0)
print("Account balance: \(bankAccount.balance)")
```
