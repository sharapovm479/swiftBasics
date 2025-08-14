//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

//// Same//
//func name(parameters) -> Void {
//    
//}
//func name(parameters) {
//    
//}



//func sumOfTwo(x:Int, y:Int) -> Int {
//    return x+y
//}
//print(sumOfTwo(x: 1,y: 2))

func sumOfTwo(_ x:Int,_ y:Int) -> Int {
    return x+y
}
print(sumOfTwo(1,2))

var strTest = "abcd"
for c in strTest {
    print(c)
}

















//Closures are self-contained blocks of functionality that can be passed around and used in your code. Closures in Swift are similar to closures, anonymous functions, lambdas, and blocks in other programming languages.















// How to o call a generic function with its type parameter bound to the runtime type of an Any
//https://forums.swift.org/t/selecting-generic-function-type-parameter-from-any/40848



// learn more about Any, AnyObject, Any.Type, T.Type
// AnyObject = any class instance, like storing UIkit contols in one array
// Any , any value, class, for exemple append differnt types in array, Int, String, Bool
// Any.Type

// how to use generic parameter in closure
// https://stackoverflow.com/questions/68463656/using-generic-parameter-in-closure


//Why is (any Any).Type different to any Any.Type?
// https://forums.swift.org/t/why-is-any-any-type-different-to-any-any-type/62099














//// How to pass a generic function as an argument, while keeping it generic
//
//
//func foo(_ f: <T> (T) -> T) {
//       //  ^~~~~~~~~~~~~~~ first-class generic closure
//  f(1)
//  f(2.0)
//  f(3 as UInt8)
//}
//let identity: <T> (T) -> T = { $0 }
//foo(identity)
//
//
//
//
//
//// `Rank2Function` represents `<T> (T) -> T`.
//protocol Rank2Function {
//  static func callAsFunction<T>(_ input: T) -> T
//                         // ^~~ higher-rank type parameters bound here
//}
//func foo<Fn: Rank2Function>(_ f: Fn.Type) {
//  // `static func callAsFunction` sugar isn't supported yet, so we have to spell it out.
//  f.callAsFunction(1)
//  f.callAsFunction(2.0)
//  f.callAsFunction("Hello")
//}





