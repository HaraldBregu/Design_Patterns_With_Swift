import UIKit
import Foundation


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
