//: [Previous](@previous)

import UIKit
import Foundation


import Dispatch


//  might need to import PlaygroundSupport because playgrounds terminate immediately after the last line of code executes, but we have asynchronous network calls so we need to tell the playground to keep running until we tell it to stop and add (Thread.sleep(forTimeInterval: 3) ) to make it sleep after some thred

// Closures are self-contained blocks of functionality that can be passed around and used in your code, A closure can be thought of as a variable that holds code. So, where an integer holds "0" or "500", a closure holds lines of Swift code. In simple words, closure is a functions without a name.


// there are mainly two type of closures, escaping and non escaping, by default closures use non escaping , we we want to have escaping clousure then we must use @escaping
// also we have trailing closure, and autoclosure

////self - explicit reference to the current type or instance of the type in which it occurs.
//
//class MyClass {
//  func showClass() {
//       print("\(self)")
//    }
//  }
//let someClass = MyClass()
//someClass.showClass()
//// prints "MyClass"
////Self - Used specifically in protocol and extension declarations to refer to the eventual type that will conform to the protocol.
//
//protocol MyProtocol {
//   static func returnSelf() -> Self
//}
//
//class MyClass: MyProtocol {
//   // define class
//}
//
//MyClass.returnSelf()
//// returns MyClass
////The difference is that self is used in types and instances of types to refer to the type that it's in; and Self is used in protocols and extensions where the actual type is not yet known.
//
////In even simpler terms, self is used within an existing type; Self is used to refer to a type that Self is not yet in.


//func fetchPrice(completion: @escaping (Error?) -> Void) { }

// MARK: closures are reference types

// MARK: trailing closure
func addNumber(_ a: Int, _ b: Int, trailingClosure: (Int) -> Void) -> Int {
    return a + b
}
addNumber(2,3) { (result) in
    print(result)
}

// MARK: Autoclosure
// autoclosure great to use in debuging, diagnostic, Unit tests but avoid using autoclosure for business, the right hand side of nil coalescing operator is autoclosure?
enum LogLevel {
    case debug
}
func appLog(_ level: LogLevel,_ message: @autoclosure ()-> String) {
    
    #if DEBUG
    if level == .debug {
        let built = message() // build only when needed
    }
    #endif
}

// MARK: Non-escaping closure,
//func nonEscapingClosre(completion: () -> Void) {
//    completion()
//    print("end of function")
//}
//
//nonEscapingClosre(completion: {print("test non escaping")}) // normal order


func escapingClosre(completion: @escaping () -> Void) {
    completion()
    print("end of function")
}

escapingClosre(completion: {print("escaping")})

// we can delay
func doLater(_ task: @escaping () -> Void) {
    
    DispatchQueue.global(qos: .default).asyncAfter(deadline: .now() + 3) {
        
        task()
        
        
    }
    print("after Task")
}
doLater {
    print("Executed after 1 second!")
}




// 1. CLOSURES AND TYPES
print("1. Closures and types:")
let closure1: (String) -> String = { name in "Hello, \(name)!" }

print(closure1("Moto"))


// 2. MULTIPLY CLOSURE

let multiply: (Int, Int) -> Int = { a, b in
    return a * b
}
print("5 * 6 = \(multiply(5, 6))")

// without in

let multiplyWihtouIN: (Int, Int) -> Int = {
    return $0 * $1
}
print("5 * 6 = \(multiplyWihtouIN(5, 6))")



var myMultiply = multiply
print("5 * 6 = \(myMultiply(5, 6))")

// 3. makeCounter()

func makeCounter() -> () -> Int {
    var count = 0
    return {
        count += 1
        return count
    }
}
let counter = makeCounter()
print("\(counter()), \(counter()), \(counter())")

// 4. performLater

func performLater(_ task: @escaping () -> Void) {
    DispatchQueue.global(qos: .default).asyncAfter(deadline: .now() + 2) {
        task()
    }
}
performLater {
    print("Executed after 1 second!")
}

// 5. retry

func retry(times: Int, action: @escaping () -> Bool) {
    DispatchQueue.global(qos: .default).async {
        for i in 1...times {
            print("Attempt #\(i)")
            if action() {
                print("Success!")
                return
            }
            if i < times {
                Thread.sleep(forTimeInterval: 0.5)
            }
        }
        print("Failed after \(times) attempts")
    }
}

var count = 0
retry(times: 3) {
    count += 1
    return count >= 2
}






// MARK: - Cacheable Protocol from prev assignment
//
protocol Cacheable {
    //  using mutating because by default struct methods cannot modify the struct's properties since structs have value semantics and are immutable by default,
    mutating func save(key: String, value: Double)

    func load(key: String) -> Double?
}


struct MemoryCache: Cacheable {

    private var cache: [String: Double] = [:]
    

    mutating func save(key: String, value: Double) {

        cache[key] = value

        print("Saved \(value) with key: \(key)")

        print("Current cache: \(cache)")
    }
    

    func load(key: String) -> Double? {

        let value = cache[key]
        //  using optional binding with if let
        if let value = value {

            print("Loaded \(value) for key: \(key)")
        } else {
 
            print("No value found for key: \(key)")
        }
 
        return value
    }
}
