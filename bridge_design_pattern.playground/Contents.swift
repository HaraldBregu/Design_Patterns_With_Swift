import UIKit

protocol DrawAPI {
    func drawCircle(radius: Int, x: Int, y: Int)
}

class RedCircle: DrawAPI {
    func drawCircle(radius: Int, x: Int, y: Int) {
        print("Drawing Red Circle, radius: \(radius), x: \(x), y: \(y)")
    }
}

protocol Shape {
    func draw()
}

class Circle: Shape {
    let radius: Int
    let x: Int
    let y: Int
    let drawAPI: DrawAPI
    
    init(radius: Int, x: Int, y: Int, drawAPI: DrawAPI) {
        self.radius = radius
        self.x = x
        self.y = y
        self.drawAPI = drawAPI
    }
    
    func draw() {
        drawAPI.drawCircle(radius: radius, x: x, y: y)
    }
}


let redCircle = Circle(radius: 10, x: 5, y: 6, drawAPI: RedCircle())
redCircle.draw()
