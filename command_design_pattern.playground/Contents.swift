import UIKit


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
