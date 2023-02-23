import UIKit

class Circle {
    var color: String
    
    init(color: String) {
        self.color = color
    }
    
    func draw(x: Int, y: Int, radius: Int) {
        print("Drawing circle of color \(color) at (\(x),\(y)) with radius \(radius)")
    }
}

class CircleFactory {
    var circles = [String: Circle]()
    
    func getCircle(color: String) -> Circle {
        if let circle = circles[color] {
            return circle
        } else {
            let newCircle = Circle(color: color)
            circles[color] = newCircle
            return newCircle
        }
    }
}

let circleFactory = CircleFactory()

let redCircle = circleFactory.getCircle(color: "red")
redCircle.draw(x: 10, y: 10, radius: 5)

let blueCircle = circleFactory.getCircle(color: "blue")
blueCircle.draw(x: 20, y: 20, radius: 10)

let anotherRedCircle = circleFactory.getCircle(color: "red")
anotherRedCircle.draw(x: 30, y: 30, radius: 7)
