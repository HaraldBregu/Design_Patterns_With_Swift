import UIKit


class Person {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

protocol Mediation {
    func completeTransaction(seller: Seller)
}

class PersonMediator: Person, Mediation {
    private var counterParts = [Person]()
    
    var offer: Double = 0.0
    var acceptedOffer: Bool = false
    
    func register(counterpart: Person) {
        counterParts.append(counterpart)
    }
    
    func completeTransaction(seller: Seller) {
        print(seller.message)
    }
}


class CounterPart: Person {
    var mediator: PersonMediator
    
    init(name: String, mediator: PersonMediator) {
        self.mediator = mediator
        super.init(name: name)
    }
}

class Buyer: CounterPart {
    override init(name: String, mediator: PersonMediator) {
        super.init(name: name, mediator: mediator)
    }
    
    func sendOffer(_ offer: Double) {
        print("I am sending an offer of \(offer) dollars")
        mediator.offer = offer
    }
}

class Seller: CounterPart {
    override init(name: String, mediator: PersonMediator) {
        super.init(name: name, mediator: mediator)
    }
     
    var message: String {
        if mediator.offer > 190_000 {
            return "I will accept your offer of \(mediator.offer) dollars"
        }
        return "I will not accept your offer of \(mediator.offer) dollars"
    }
}

var mediator = PersonMediator(name: "Agent Smith")

var buyer = Buyer(name: "Marina Mitchell", mediator: mediator)
mediator.register(counterpart: buyer)

var seller = Seller(name: "Dillan Grimes", mediator: mediator)
mediator.register(counterpart: seller)

buyer.sendOffer(100_000)

mediator.completeTransaction(seller: seller)

buyer.sendOffer(200_000)

mediator.completeTransaction(seller: seller)
