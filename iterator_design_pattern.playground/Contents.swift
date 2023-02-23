import UIKit

protocol Iterator {
    associatedtype Element
    func hasNext() -> Bool
    func next() -> Element?
}

class ArrayIterator<T>: Iterator {
    typealias Element = T
    
    private var currentIndex = 0
    private let elements: [Element]
    
    init(elements: [Element]) {
        self.elements = elements
    }
    
    func hasNext() -> Bool {
        return currentIndex < elements.count
    }
    
    func next() -> Element? {
        guard hasNext() else { return nil }
        defer { currentIndex += 1 }
        return elements[currentIndex]
    }
}

struct MyCollection<T> {
    private let elements: [T]
    
    init(elements: [T]) {
        self.elements = elements
    }
    
    func makeIterator() -> ArrayIterator<T> {
        return ArrayIterator(elements: elements)
    }
}

let myCollection = MyCollection(elements: [1, 2, 3, 4, 5])
var iterator = myCollection.makeIterator()

while iterator.hasNext() {
    if let element = iterator.next() {
        print(element)
    }
}
