import UIKit

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
