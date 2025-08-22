//: [Previous](@previous)

import Foundation


//Assignment  7
//In Swift playgorund have multiple examples to show usage of below:
//1.Higher order functions
//    
//Use map to convert an array of Celsius temps to Fahrenheit.
//Use filter to extract all odd numbers from [1...20].
//Use reduce to multiply all numbers in [1,2,3,4].
//Use sorted to arrange names alphabetically.
//Given a list of sentences, use flatMap to break them into words.
// 
//Generic
//Create Stack for String using Genrics
//Write a generic function maxValue<T: Comparable>( a: T,  b: T) -> T.
//Create a generic Queue<T> type with enqueue and dequeue.
//Write a generic function to reverse any array.
//Show use of Genrics for enum
//Show use of Genrics for Class
//
//AssociatedType
//Define a protocol QueueProtocol with an associated type Element.
//Implement IntQueue and StringQueue.
//Show 2 differnt examples of AssociatedType usages

// higher-order functions are functions that operate on other functions. This means they can either: Take one or more functions as arguments (parameters), Return a function as their result, and Do both.



var numbers: [Int] = [1, 4, 9, 16, 25]
var squares: [Int] = []

let squareRoots: [Int] = []



numbers.map { $0 * $0 }.forEach { squares.append($0) }

print(squares)

struct Person {
    var name: String
    var age: Int
    var email: String?
}

let employees: [Person] = [Person(name: "Bob", age: 30, email: "bob@gmail.com"), Person(name: "Alice", age: 25, email: nil), Person(name: "Charlie", age: 42, email: "charlie@gmail.com"),Person(name: "Neff", age: 99, email: "neff@gmail.com")]

let names: [String] = employees.map(\.name)
let ages: [Int] = employees.map(\.age)
print(names)


// flatMap is "map, and then flatten." "Flatten" means to turn a Sequence of Sequences in an single Array containing all the elements. [ [1,2], [3,4] ] becomes [1,2,3,4].
var flatMapExample: [[Int]] = [[1, 2], [3, 4], [5]]
let flattened: [Int] = flatMapExample.flatMap(\.self)
print(flattened)

// compactMap(_:):
//Similar to map, but it also handles optionals by unwrapping and discarding nil values, returning an array of non-optional elements.
let showCaseCompactMap: [String?] = ["Alice", "Bob", nil, "Charlie", "David", nil]
let compactMapExample: [String] = showCaseCompactMap.compactMap(\.self)
print(compactMapExample)

let ageFilter = employees.filter { $0.age > 30 }.map(\.name)

let filterEmail:[String] = employees.compactMap(\.name).filter { $0.hasSuffix("@gmail.com") }
print("filterEmail",filterEmail)

// list all higher order functions
//"map", "filter", "reduce", "flatMap", "compactMap", "sorted", "joined", "split", "joined(separator:)", "zip"]

let showCaseReduce: [Int] = [1, 2, 3, 4, 5]
let resultReduce: Int = showCaseReduce.reduce(0, +) // adding all
let resultReduce2: Int = showCaseReduce.reduce(10, +) 
print(resultReduce)
print(resultReduce2)

let showCaseSort: [Int] = [64, 34, 25, 12, 22, 11, 90]
let resultSort: [Int] = showCaseSort.sorted()
let resultSortDescending: [Int] = showCaseSort.sorted(by: >)
print(resultSort)
print(resultSortDescending)


let fristName:[String] = ["Bob", "Alice", "David", "Charlie"]
let age:[Int] = [30, 25, 42, 22]

var zipExample: [(String, Int)] = []
for (index, value) in fristName.enumerated() {
    zipExample.append((value, age[index]))
}
print(zipExample)

//var zipExampleClosure: [String:Int] = [:]
var zipExampleClosure = zip(fristName, age)
print(zipExampleClosure)



// MARK: Generics
// Generics are functions that can work with any types

func genericFunction<T>(parameter: T) -> T {
    return parameter
}

class GenericClass<T> {
    var value: T
    
    init(value: T) {
        self.value = value
    }
    func getData() -> T {
        return value
    }
}

struct GenericStruct<T> {
    var value: T
    
    init(value: T) {
        self.value = value
    }
}

struct Queue<T> {
    private var elements: [T] = []
    
    mutating func enqueue(_ element: T) {
        elements.append(element)
    }
    func isEmpty() -> Bool? {
        return elements.isEmpty ? true : nil
    }
    mutating func dequeue() -> T? {
        guard isEmpty == nil else { return nil }
        return elements.removeFirst()
    }
}


//MARK: An associated type
//When defining a protocol, it’s sometimes useful to declare one or more associated types as part of the protocol’s definition. An associated type gives a placeholder name to a type that’s used as part of the protocol. The actual type to use for that associated type isn’t specified until the protocol is adopted. Associated types are specified with the associatedtype keyword.






//1.Higher order functions
//
//Use map to convert an array of Celsius temps to Fahrenheit.
var arrayOfCelsius: [Double] = [0, 100, -40, 20]
let arrayOfFahrenheit: [Double] = arrayOfCelsius.map { (celsius: Double) -> Double in
    return (celsius * 9.0 / 5.0) + 32.0
}
print(arrayOfFahrenheit)
//Use filter to extract all odd numbers from [1...20].
var oddNumber: [Int] = []
for i in 1...20 {
    if i.isMultiple(of: 2) {
        continue
    }
    oddNumber.append(i)
}
print(oddNumber)
//Use reduce to multiply all numbers in [1,2,3,4].
var arr:[Int] = [1,2,3,4]
let result: Int = (1...4).reduce(1, *)

//Use sorted to arrange names alphabetically.
var namesSort: [String] = ["Bob", "Charlie","Alice"]
namesSort.sorted()
print(namesSort)

//Given a list of sentences, use flatMap to break them into words.

var listOfSentence: [String] = ["Hello World","Hello World","Hello World"]
var listOfWords: [String] = listOfSentence.flatMap { $0.components(separatedBy: " ") }
print(listOfWords)


//Generic
//Create Stack for String using Genrics
struct Stack<Element> {
    var items: [Element] = []
    mutating func push(_ element: Element) {
        items.append(element)
    }
    mutating func pop() -> Element? {
        return items.popLast()
    }
}

//Write a generic function maxValue<T: Comparable>( a: T,  b: T) -> T.
func genericFuncMaxValue<T: Comparable>(a: T, b: T) -> T {
    return a > b ? a : b
}
print(genericFuncMaxValue(a: 10, b: 20))

//Create a generic Queue<T> type with enqueue and dequeue.
struct QueueG<T> {
    var items: [T] = []
    mutating func enqueue(_ element: T) {
        items.append(element)
    }
    mutating func dequeue() -> T? {
        return items.removeFirst()
    }
}
var genericQ = QueueG<Int>()
genericQ.enqueue(1)
genericQ.enqueue(2)
genericQ.enqueue(3)
genericQ.enqueue(4)
genericQ.dequeue()!
print(genericQ.dequeue()!)
//Write a generic function to reverse any array.
func reverseArray<T>(_ array: inout [T]) -> [T]? {
    
    return Array(array.reversed())
    }
var arrRevTest: [Int] = [1,2,3,4]
var res = reverseArray(&arr)
print(res)

//Show use of Genrics for enum
enum GenericEnum {
    case int(Int)
    case string(String)
}
//Show use of Genrics for Class
class GenericClasss<T> {
    var value: T
    init(_ value: T) {
        self.value = value
    }
}
//
//AssociatedType is used via protocols to create more customusible gneric, or type,
//Define a protocol QueueProtocol with an associated type Element.
protocol QueueProtocol {
    associatedtype Element
    var items: [Element] { get set }
    mutating func enqueue(_ element: Element)
    mutating func dequeue() -> Element?
}

struct IntQueue: QueueProtocol {
    var items: [Int] = []
    
    mutating func enqueue(_ element: Int) {
        items.append(element)
    }
    
    mutating func dequeue() -> Int? {
        return items.removeFirst()
    }
}

var testIntQueue = IntQueue()
testIntQueue.enqueue(1)
testIntQueue.enqueue(2)
testIntQueue.enqueue(3)
testIntQueue.enqueue(4)
testIntQueue.dequeue()!
print(testIntQueue.dequeue()!)





//Implement IntQueue and StringQueue.
struct StringQueue: QueueProtocol {
    var items: [String] = []
    
    mutating func enqueue(_ element: String) {
        items.append(element)
    }
    
    mutating func dequeue() -> String? {
        return items.removeFirst()
    }
}

var testStringQueue = StringQueue()
testStringQueue.enqueue("1")
testStringQueue.enqueue("2")
testStringQueue.enqueue("3")
testStringQueue.enqueue("4")
testStringQueue.dequeue()!
print(testStringQueue.dequeue()!)

//Show 2 differnt examples of AssociatedType usages


