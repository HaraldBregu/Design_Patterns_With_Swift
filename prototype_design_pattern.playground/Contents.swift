import UIKit


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
