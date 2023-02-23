import UIKit

protocol TextFormatter {
    func format(text: String) -> String
}

class PlainTextFormatter: TextFormatter {
    func format(text: String) -> String {
        return text
    }
}

class BoldTextDecorator: TextFormatter {
    private let wrappedFormatter: TextFormatter
    
    init(_ formatter: TextFormatter) {
        self.wrappedFormatter = formatter
    }
    
    func format(text: String) -> String {
        let wrappedText = wrappedFormatter.format(text: text)
        return "<b>\(wrappedText)</b>"
    }
}

class ItalicTextDecorator: TextFormatter {
    private let wrappedFormatter: TextFormatter
    
    init(_ formatter: TextFormatter) {
        self.wrappedFormatter = formatter
    }
    
    func format(text: String) -> String {
        let wrappedText = wrappedFormatter.format(text: text)
        return "<i>\(wrappedText)</i>"
    }
}

let plainText = "Hello, world!"
let plainFormatter = PlainTextFormatter()
print(plainFormatter.format(text: plainText)) // Output: Hello, world!

let boldFormatter = BoldTextDecorator(plainFormatter)
print(boldFormatter.format(text: plainText)) // Output: <b>Hello, world!</b>

let italicFormatter = ItalicTextDecorator(boldFormatter)
print(italicFormatter.format(text: plainText)) // Output: <i><b>Hello, world!</b></i>
