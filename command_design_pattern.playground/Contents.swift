import UIKit



/// The Command interface declares a method for executing a command.
protocol Command {

    func execute()
}

/// Some commands can implement simple operations on their own.
class SimpleCommand: Command {

    private var payload: String

    init(_ payload: String) {
        self.payload = payload
    }

    func execute() {
        print("SimpleCommand: See, I can do simple things like printing (" + payload + ")")
    }
}

/// However, some commands can delegate more complex operations to other
/// objects, called "receivers."
class ComplexCommand: Command {

    private var receiver: Receiver

    /// Context data, required for launching the receiver's methods.
    private var a: String
    private var b: String

    /// Complex commands can accept one or several receiver objects along with
    /// any context data via the constructor.
    init(_ receiver: Receiver, _ a: String, _ b: String) {
        self.receiver = receiver
        self.a = a
        self.b = b
    }

    /// Commands can delegate to any methods of a receiver.
    func execute() {
        print("ComplexCommand: Complex stuff should be done by a receiver object.\n")
        receiver.doSomething(a)
        receiver.doSomethingElse(b)
    }
}

/// The Receiver classes contain some important business logic. They know how to
/// perform all kinds of operations, associated with carrying out a request. In
/// fact, any class may serve as a Receiver.
class Receiver {

    func doSomething(_ a: String) {
        print("Receiver: Working on (" + a + ")\n")
    }

    func doSomethingElse(_ b: String) {
        print("Receiver: Also working on (" + b + ")\n")
    }
}

/// The Invoker is associated with one or several commands. It sends a request
/// to the command.
class Invoker {

    private var onStart: Command?

    private var onFinish: Command?

    /// Initialize commands.
    func setOnStart(_ command: Command) {
        onStart = command
    }

    func setOnFinish(_ command: Command) {
        onFinish = command
    }

    /// The Invoker does not depend on concrete command or receiver classes. The
    /// Invoker passes a request to a receiver indirectly, by executing a
    /// command.
    func doSomethingImportant() {

        print("Invoker: Does anybody want something done before I begin?")

        onStart?.execute()

        print("Invoker: ...doing something really important...")
        print("Invoker: Does anybody want something done after I finish?")

        onFinish?.execute()
    }
}

let invoker = Invoker()
invoker.setOnStart(SimpleCommand("Say Hi!"))

let receiver = Receiver()
invoker.setOnFinish(ComplexCommand(receiver, "Send email", "Save report"))
invoker.doSomethingImportant()
