import UIKit

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
