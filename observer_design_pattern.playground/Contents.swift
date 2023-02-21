import UIKit

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
