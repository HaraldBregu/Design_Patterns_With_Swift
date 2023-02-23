import UIKit

indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case subtraction(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
    case division(ArithmeticExpression, ArithmeticExpression)
}

class ArithmeticInterpreter {
    func interpret(_ expression: ArithmeticExpression) -> Int {
        switch expression {
        case .number(let value):
            return value
        case .addition(let left, let right):
            return interpret(left) + interpret(right)
        case .subtraction(let left, let right):
            return interpret(left) - interpret(right)
        case .multiplication(let left, let right):
            return interpret(left) * interpret(right)
        case .division(let left, let right):
            return interpret(left) / interpret(right)
        }
    }
}

let expression = ArithmeticExpression.addition(
    .number(2),
    .multiplication(
        .addition(
            .number(3),
            .number(2)
        ),
        .number(4)
    )
)

let interpreter = ArithmeticInterpreter()
let result = interpreter.interpret(expression)
print(result) // Output: 26
