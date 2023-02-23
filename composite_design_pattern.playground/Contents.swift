import UIKit

protocol Shape {
    func draw()
}

class Circle: Shape {
    func draw() {
        print("a circle")
    }
}

class Rectangle: Shape {
    func draw() {
        print("a rectangle")
    }
}

class Drawing: Shape {
    private var shapes = [Shape]()
    
    func add(shape: Shape) {
        shapes.append(shape)
    }
    
    func draw() {
        print("Drawing..")
        for shape in shapes {
            shape.draw()
        }
    }
}

let circle = Circle()
let rectangle = Rectangle()
let drawing = Drawing()

drawing.add(shape: circle)
drawing.add(shape: rectangle)
drawing.draw()
