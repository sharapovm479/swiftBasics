//: [Previous](@previous)

import Foundation




//MARK: Assignment 3
//In Swift playgorund have multiple examples to show usage of below:
//1.tuples- differnt types
//2.Loops (for loop , while loop, repeat while)
//3.Conditional statements
//4.Optionals and Optional Bindings
//5.for Loops:
//Print numbers from 10 down to 1 using a stride.
// Given [1,2,3,4,5,6], print only even numbers using for case/where.
// Remove all odd numbers from an array safely while iterating.
// Simulate retrying an operation up to 5 times with a while loop, then print success/failure.
//6.Tuples
//    a.    Create a tuple to store a student’s name, roll number, and marks. Print them using both positional and named access.
//    b.    Write a function divide(_:by:) that returns both the quotient and remainder as a tuple.
//    c.    Write a function returning a tuple (success: Bool, message: String) for login validation.
//Conditional statements
//Write an if that prints “Even” if a number is even, else “Odd”
//Use switch to print the season for a given month number.
//Validate a username with guard so it’s at least 5 characters.


//: [Next](@next)
////var arrNums: [Int] = [1,2,3,4]
//create two D array





//for num in arrNums {
//    print("num",num)
//}
//for i in 0..<arrNums.count {
//    print("i",arrNums[i])
//}



//// for graphs num are nodes
//
//
//var TwoDArr: [[Int]] = [[1,2,3],[4,5,6]]
//// loop via nested 2 d array
//for i in 0..<TwoDArr.count {
//    for j in 0..<TwoDArr[i].count {
//        print("i\(i),j:\(j), TwoDArr[\(i)][\(j)]: \(TwoDArr[i][j])")
//    }
//}


//for i in stride(from: 0, to: arrNums.count-1, by: 1) {
//    
//}

//for in stride(from: <#T##Strideable#>, through: <#T##Strideable#>, by: <#T##Comparable & SignedNumeric#>)

//var arrTuples: [(Int,String)] = [(1,"a"),(2,"b"),(3,"c")]
//
//for (index,value) in arrTuples.enumerated() {
//    print("index:\(index), value:\(value)")
//}



//
// MARK: While



//// two pointers
//
//var left = 0
//var right = arrNums.count - 1
//
//while left < right {
//    let sum = arrNums[left] + arrNums[right]
//    if sum == 0 {
//        print("Found")
//        break
//    }
//}


//var num = 30
//while num > 0 {
//    num -= 1
//}
//
//// when calling api calls
//var attempts = 0
//
//
//// repeat while loops
//var no = 1
//repeat {
//    print(no)
//    no += 1
//} while no < 10
    


// MARK: Conditional Statements

//// If else grades
//let score = 91
//if score >= 90 {
//    print("A")
//} else if score >= 80 {
//    print("B")
//} else if score >= 70 {
//    print("C")
//} else if score >= 60 {
//    print("D")
//} else {
//    print("F")
//}
//
//// switch cases
//var scoreSwitch = 91
//switch scoreSwitch {
//case 90...100:
//    print("A")
//case 80..<90:
//    print("B")
//case 70..<80:
//    print("C")
//case 60..<70:
//    print("D")
//default: break
//    
//}

// guard (is used for early exit, when we want to exit early)
//let number = 5
//
//func studyGuardStatement() {
//    guard number > 0 else {
//        print("number is invalid")
//        return
//    }
//    print("cointinue the code ")
//}

// switch cases // break , fallthrough, continue
// switch commonly used with enums

//enum BBPhoto1: Int {
//    case kommunen = 10
//    case sagsbehandler = 20
//    case festen = 30
//}
//
//var selectedPhoto: BBPhoto1?
//
//if let selectedPhoto = selectedPhoto {
//    switch (selectedPhoto) {
//    case .kommunen:
//        println(selectedPhoto.toRaw())
//
//    case .sagsbehandler:
//        println(selectedPhoto.toRaw())
//
//    default:
//        println("none")
//    }
//}

//The fallthrough keyword simply causes code execution to move directly to the statements inside the next case (or default case) block


var scoreSwitch = 91
var arrStudents = [10, 100, 90, 93]
switch scoreSwitch {
case 90...100:
    print("A")
    // to use continue , count how many students got A
case 80..<90:
    print("B")
    fallthrough
case 70..<80:
    print("C")
case 60..<70:
    print("D")
default: break

}




//let points = [(10, 0), (30, -30), (-20, 0)]
//
//for case let (x, y) in points where x == y || x == -y  {
//    print("Found (\(x), \(y)) along a line through the origin")
//}


// 6. Ternary operator - its a shorhand for if else conditions



// An optional is a data type that can either hold a value or be empty (nil/null).

// optionals is enum behind the scene with 2 cases, ca. none(nio) case .come(T)(valeu), optionals helps us in writing safer

var n1: Int? = 10

//MARK: Optional binding is a feature in Swift that allows us to safely work with optional values, preventing crashes due to unexpected nil values

//optional binding
// if let
if let num = n1 {
    print(num)
}
// guard let
func printNum(_ num: Int?) {
    guard let num = num else {
        print("Number is nil")
        return
    }
    print(num)
}


// Nil collesing operator

let name: String? = nil
let unwrappedName = name ?? "Anonymous"

print("Hi, \(name ?? "Anonymous")")

// force unwrapping, make sure it's never nil before using force, we never use force unwrapping in the real world apps

// optional chaining
