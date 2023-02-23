import UIKit

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
