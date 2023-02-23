import UIKit

protocol Strategy {
    func execute(_ data: [Int]) -> [Int]
}

class BubbleSortStrategy: Strategy {
    func execute(_ data: [Int]) -> [Int] {
        var array = data
        for i in 0..<array.count {
            for j in 1..<array.count - i {
                if array[j] < array[j-1] {
                    let temp = array[j-1]
                    array[j-1] = array[j]
                    array[j] = temp
                }
            }
        }
        return array
    }
}

class QuickSortStrategy: Strategy {
    func execute(_ data: [Int]) -> [Int] {
        guard data.count > 1 else {
            return data
        }

        let pivot = data[data.count / 2]
        let less = data.filter { $0 < pivot }
        let equal = data.filter { $0 == pivot }
        let greater = data.filter { $0 > pivot }

        return execute(less) + equal + execute(greater)
    }
}

class Context {
    private let strategy: Strategy

    init(strategy: Strategy) {
        self.strategy = strategy
    }

    func executeStrategy(_ data: [Int]) -> [Int] {
        return strategy.execute(data)
    }
}

let data = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
let context1 = Context(strategy: BubbleSortStrategy())
let sortedData1 = context1.executeStrategy(data)
print("Sorted data using bubble sort strategy: \(sortedData1)")

let context2 = Context(strategy: QuickSortStrategy())
let sortedData2 = context2.executeStrategy(data)
print("Sorted data using quick sort strategy: \(sortedData2)")
