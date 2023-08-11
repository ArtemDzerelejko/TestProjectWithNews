import UIKit

let array = [5, 2, 4, 1, 8, 9]

func findMinimumElemtn(in array: [Int]) -> Int? {
    
    guard !array.isEmpty else {
        return nil
    }
    
    if array.count == 1 {
        return array.first
    }
    
    let subArray = Array(array.dropLast())
    let minElement = findMinimumElemtn(in: subArray)
    
    if let lastElement = array.last, let minElement = minElement {
        return min(lastElement, minElement)
    }
    
    return nil
}

let minimum = findMinimumElemtn(in: array)
print("Мінімальний елемент: \(minimum ?? -1)")
