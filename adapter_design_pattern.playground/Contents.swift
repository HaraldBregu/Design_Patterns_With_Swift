import UIKit


protocol Speaking {
    func speak()
}

protocol Woofing {
    func woof()
}

protocol Jumping {
    func jump()
}


class Human: Speaking, Jumping {
    
    func speak() {
        print("Humans can speak")
    }
    
    func jump() {
        print("Humans can jump")
    }
    
}

class Animal: Jumping, Woofing {
    
    func jump() {
        print("Animals can jump")
    }
    
    func woof() {
        print("Some animals can woof")
    }
    
}

let human = Human()
human.jump()
human.speak()

let animal = Animal()
animal.jump()
animal.woof()
