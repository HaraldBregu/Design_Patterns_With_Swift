import UIKit

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
