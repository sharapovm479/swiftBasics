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

// tuples- differnt types of tuples

//let httpStatus = (statusCode: 200, message: "OK")
//print("Status Code: \(httpStatus.statusCode)")
//print("Message: \(httpStatus.message)")
//
//let location = (longitude: 12421.12, latitude: 34323.12)
//print("Longitude: \(location.longitude)")
//print("Latitude: \(location.latitude)")
//
//var employee = ("Bob", "123 Street Dr", "1", 1)
//print("Name: \(employee.0)")
//print("Address: \(employee.1)")
//print("Age: \(employee.2)")
//print("ID: \(employee.3)")







var arrNums: [Int] = [1,2,3,4]
//create twoD array





for num in arrNums {
    print("num",num)
}
for i in 0..<arrNums.count {
    print("i",arrNums[i])
}




////
////
//var TwoDArr: [[Int]] = [[1,2,3],[4,5,6]]
//// loop via nested 2 d array
//for i in 0..<TwoDArr.count {
//    for j in 0..<TwoDArr[i].count {
//        print("i\(i),j:\(j), TwoDArr[\(i)][\(j)]: \(TwoDArr[i][j])")
//    }
//}


for i in stride(from: 10, to: 0, by: -12) {
 print(i) // it will reach to 9
}

for i in stride(from: 0, through: 10, by: 1) {
    print(i)
}

var arrTuples: [(Int,String)] = [(1,"a"),(2,"b"),(3,"c")]


for (index,value) in arrTuples.enumerated() {
    print("index:\(index), value:\(value)")
}



//
// MARK: While



//// two pointers
//
var left = 0
var right = arrNums.count - 1

while left < right {
    let sum = arrNums[left] + arrNums[right]
    if sum == 0 {
        print("Found")
        break
    }
    left += 1
    right -= 1
}


//var num = 30
//while num > 0 {
//    num -= 1
//}
//
//// when calling api calls
//var attempts = 0


// repeat while loops
var no = 1
repeat {
    print(no)
    no += 1
} while no < 10
    


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
////
////// switch cases
//var scoreSwitch = 81
//switch scoreSwitch {
//case 90...100:
//    print("A")
//case 80..<90:
//    print("B")
//    fallthrough
//case 70..<80:
//    print("C")
//case 60..<70:
//    print("D")
//default: break
//
//}

 // guard (is used for early exit, when we want to exit early)
let number = 5

func studyGuardStatement() {
    guard number > 0 else {
        print("number is invalid")
        return
    }
    print("cointinue the code ")
}

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


//var scoreSwitch = 80
//var arrStudents = [10, 100, 90, 93]
//switch scoreSwitch {
//case 90...100:
//    print("A")
//    // to use continue , count how many students got A
//case 80..<90:
//    print("B")
//    fallthrough
//case 70..<81:
//    print("C")
//case 60..<70:
//    print("D")
//default: break
//
//}




//let points = [(10, 0), (30, -30), (-20, 0)]
//////
//for case let (x, y) in points where x == y || x == -y  {
//    print("Found (\(x), \(y)) along a line through the origin")
//}
//
//
// 6. Ternary operator - its a shorthand for if else conditions
//var switchF = false
//var anotherSwitch = true
//
//print(switchF == anotherSwitch ? true : false)
//if switchF == anotherSwitch {
//    print("true")
//} else {
//    print("false")
//}
//
//
//
// An optional is a data type that can either hold a value or be empty (nil/null).
//
// optionals is enum behind the scene with 2 cases, ca. none(nio) case .come(T)(valeu), optionals helps us in writing safer

var n1: Int? = 10

//MARK: Optional binding is a feature in Swift that allows us to safely work with optional values, preventing crashes due to unexpected nil values

//optional binding
// if let
if let num = n1 {
    print(num)
}
//// guard let
func printNum(_ num: Int?) {
    guard let num = num else {
        print("Number is nil")
        return
    }
    print(num)
}
//
//
//// Nil collesing operator
//
//let name: String? = nil
//let unwrappedName = name ?? "Anonymous"
//
//print("Hi, \(name ?? "Anonymous")")

// force unwrapping, make sure it's never nil before using force, we never use force unwrapping in the real world apps


// optional chaining

////MARK: Assignment 3
////In Swift playgorund have multiple examples to show usage of below:
////1.tuples- differnt types
////2.Loops (for loop , while loop, repeat while)
////3.Conditional statements
////4.Optionals and Optional Bindings
////5.for Loops:
////Print numbers from 10 down to 1 using a stride.
//
//var testArrayThr: [Int] = []
//for n in stride(from: 10, through: 1, by: -1) {
//    print("\(n)")
//    testArrayThr.append(n)
//}
//print("testArrayThr",testArrayThr)
//
//var testArrayTo: [Int] = []
//for n in stride(from: 10, to: 0, by: -1) {
//    print("\(n)")
//    testArrayTo.append(n)
//}
//print("testArrayTo",testArrayTo)

// Given [1,2,3,4,5,6], print only even numbers using for case/where.
var arrGiven : [Int] = [1,2,3,4,5,6]

for num in arrGiven where num.isMultiple(of: 2) {
    print(num)
}
//or
for num in arrGiven {
    if num % 2 == 0 {
        print(num)
    }
}
//// Remove all odd numbers from an array safely while iterating.
var i = 0
while i < arrGiven.count{
    if arrGiven[i] % 2 != 0 {
        arrGiven.remove(at: i)
    }
    i+=1
}
//print(arrGiven)
//// Simulate retrying an operation up to 5 times with a while loop, then print success/failure.
//
//var attempts = 0
//var maxAtt = 5
//var loginSuccessFailHistory: [String] = []
//while attempts < maxAtt {
//    if attempts == maxAtt {
//        print("Failed")
//        loginSuccessFailHistory.append("Failed")
//        
//    } else {
//        print("Success on \(attempts + 1)")
//        loginSuccessFailHistory.append("Success")
//        attempts += 1
//    }
//}
//print("loginSuccessFailHistory",loginSuccessFailHistory)
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
////6.Tuples
////    a.    Create a tuple to store a student’s name, roll number, and marks. Print them using both positional and named access.
let studentTuple = (name: "McLovin", rollNumber: 123, marks: 77)
//    b.    Write a function divide(_:by:) that returns both the quotient and remainder as a tuple.
func divide(_ dividend: Int, by divisor: Int) -> (quotient: Int, remainder: Int) {
    return (dividend / divisor, dividend % divisor)
}
//    c.    Write a function returning a tuple (success: Bool, message: String) for login validation.
func loginValidation(username: String, password: String) -> (success: Bool, message: String) {
    if username == "admin" && password == "1234" {
        return (true, "Login successful")
    } else {
        return (false, "Invalid username or password")
    }
}
////Conditional statements
////Write an if that prints “Even” if a number is even, else “Odd”
//let num = 5
//if num % 2 == 0 {
//    print("Even")
//} else {
//    print("Odd")
//}
//Use switch to print the season for a given month number.
var monthsSeason = 5
    
switch monthsSeason {
case 12,1,2:
    print("Winter")
case 3..<5:
    print("Spring")
case 5..<7:
    print("Summer")
case 7..<12:
    print("Autumn")
    
    
default:
    break
}
//Validate a username with guard so it’s at least 5 characters.

func validateUsername(_ username: String?) -> Bool {
    guard let username = username, username.count >= 5 else {
        print("less than 5")
        return false
    }
    return true
}

print(validateUsername("Bob"))
