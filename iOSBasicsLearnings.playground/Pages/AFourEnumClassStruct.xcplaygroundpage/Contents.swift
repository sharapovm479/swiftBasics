//: [Previous](@previous)

import Foundation

//Assignment 4
//In Swift playgorund have multiple examples to show usage of below:
//1.Enum- differnt types, functions and properties in enums
//Create an enum for the four seasons and print a message for each.
// Define an enum LoginState with cases loggedIn(user: String) and loggedOut.
// Create an enum with raw values for HTTP methods (GET, POST, etc.).
// Add a computed property to an enum Planet returning its order from the sun.
// Iterate over all cases of an enum TransportMode using CaseIterable.
//
//2.Class- Oops concept
//Create a class Car with properties make and model, and a method drive().
// Build an Employee class inheriting from Person with an extra property employeeID.
// Implement a class BankAccount with deposit and withdraw methods.
// Create a Shape base class and Triangle/Square subclasses overriding an area() method.
// Demonstrate reference semantics by assigning one instance to multiple variables and modifying it.
//3.Classes refrence type usage
//
//4.Structs
//Create a struct Book with properties title and author and a method description().
// Make a struct Temperature with a computed property converting Celsius to Fahrenheit
// Build a struct Vector2D with methods to add and subtract two vectors


enum Season {
    case spring
    case summer
    case autumn
    case winter
}
print(SeasonOneLine.autumn)




// to enable iteration, looping we could add CaseIterable




enum SeasonOneLine: CaseIterable {
    case spring, summer, autumn, winter
    
    func printSeason() {
        switch self {
        case .spring:
            print("Spring")
        case .summer:
            print("Summer")
        case .autumn:
            print("Autumn")
        case .winter:
            print("Winter")
        }
    }
}
var testSeason: [String] = []
for season in SeasonOneLine.allCases {
    testSeason.append("\(season)")
}
print("testSeason",testSeason)



// nested enums
enum SeasonMonths: CaseIterable {
    enum Spring: Int, CaseIterable {
        case march = 3
        case april = 4
        case may = 5
        
        var activity : String {
            switch self {
            case .march:
                return "Watch flowers bloom, celebrate my birthday"
                
            case .april:
                return "Dance in spring rain"
            case .may:
                return "5 de mayo"
            }
        }
    }
    enum Summer: Int, CaseIterable {
        case june = 6
        case july = 7
        case august = 8
        
        var activity : String {
            switch self {
            case .june:
                return "Go to the beach"
                
            case .july:
                return "Go to the beach"
            case .august:
                return "get heatstroke from the hot, steamy humidity in Atlanta"
            }
        }
    }
    enum Autumn: Int, CaseIterable {
        case september = 9
        case october = 10
        case november = 11
        var activity : String {
            switch self {
            case .september:
                return "get rekt by crypto bears"
                
            case .october:
                return "Hallooween"
            case .november:
                return "Thanksgiving"
            }
        }
    }
    enum Winter: Int, CaseIterable {
        case december = 12
        case january = 1
        case february = 2
        
        var activity : String {
            switch self {
            case .december:
                return "New Year"
                
            case .january:
                return "Pasha"
            case .february:
                return "build a snowman"
            }
        }
    }
}


print(SeasonMonths.Spring.march.activity)
print(SeasonMonths.Winter.february.activity)

// iterate and list out all the months and activities


for season in SeasonMonths.Spring.allCases {
    print("season: \(season)")
}


// Define an enum LoginState with cases loggedIn(user: String) and loggedOut.
enum LoginState {
    case loggedIn(user: String)
    case loggedOut
    
    func displayLog() {
        switch self {
        case .loggedIn(user: let user):
            print("user:\(user) logged in")
        case .loggedOut:
            print("logged out")
        }
    }
}
print("LoginState", LoginState.loggedIn(user: "Bob"))


// Create an enum with raw values for HTTP methods (GET, POST, etc.).
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case put = "PUT"
    case delete = "DELETE"
}

print(HTTPMethod.post)

// Add a computed property to an enum Planet returning its order from the sun.
enum Planet: Int {
    case mercury = 1
    case venus = 2
    case earth = 3

    case mars = 4
    case jupiter = 5
    case saturn = 6
    case uranus = 7
    case neptune = 8
    var OrderFromSun: String {
        switch self {
            case .mercury:
            return "1"
        case .venus:
            return "2"
        case .earth:
            return "3"
        case .mars:
            return "4"
        case .jupiter:
            return "5"
        case .saturn:
            return "6"
        case .uranus:
            return "7"
        case .neptune:
            return "8"
            
        @unknown default:
            return "unknown"
        }
    }
}
print(Planet.earth.OrderFromSun)



// Iterate over all cases of an enum TransportMode using CaseIterable.

enum TransportMode: CaseIterable {
    case car, train, plane, bike
    
    func printSeason() {
        switch self {
        case .car:
            print("Car")
        case .train:
            print("Train")
        case .plane:
            print("Plane")
        case .bike:
            print("Bike")
        }
    }
}
var testTransport: [String] = []
for tran in TransportMode.allCases {
    testTransport.append("\(tran)")
}
print("testTransport",testTransport)






//2.Class- Oops concept
// 4 pillars of OOP are Encapsulation , Abstraction, Inheritance, Polymorphism

//MARK: Encapsulation
// hiding data and providing controlled access through properties and methods

//public class IntegerArrayCalcuation {
//    
//    private let array: [Int]
//    private let sortedArray: [Int]
//    
//    public init(array:[Int]) {
//        self.array = array
//        sortedArray = self.array.sort {
//            return $0 < $1
//        }
//    }






//MARK:  Abstraction: in swift protocols are abstraction, we use protocols to hide complex implemention
//
//protocol PaymentMeth {
//    func doSomething {}
//}
//class CreditCard: PaymentMeth {
//    
//}
//
//class ApplePay: PaymentMeth {
//    
//}
//class GooglePay: PaymentMeth {
//    
//}

//MARK: Inheritance
// reusing parent blueprint class in child class
//class Dog {
//    var name: String
//    var age: Int
//    var color: String
//    
//    init(name: String, age: Int) {
//        self.name = name
//        self.age = age
//    }
//    
//}
//class GoldenRetriever: Dog {
//    override var name = "Rex"
//}
////MARK: Polymorphism
//class Shape {
//    func area() -> Double {
//        return 0.0
//    }
//    
//    
//}
//class Triangle: Shape {
//    func area() -> Double {
//        return 0.0
//    }
//}
//class Square: Shape {
//    override func area() -> Double {
//        return 0.0
//    }
//}
//Create a class Car with properties make and model, and a method drive().

class Car {
    var make: String
    var model: String
    
    init(make: String, model: String) {
        self.make = make
        self.model = model
    }
    
    func drive() {
        print("Drive the car")
    }
    
}
let someCar = Car(make: "Merc", model: "Gwagon")

// Build an Employee class inheriting from Person with an extra property employeeID.
class Person {
    var name: String
    var age: Int
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

class Employee: Person {
    var employeeID: Int
    
    init(name: String, age: Int, employeeID: Int) {
        self.employeeID = employeeID
        super.init(name: name, age: age)
    }
}
// Implement a class BankAccount with deposit and withdraw methods.
class BankAccount {
    private var balance = 999999.00
    
    init(balance: Double ) {
        self.balance = balance
    }
    func deposit(amount:Double) {
        balance += amount
        
    }
    func withdraw(amount:Double) -> Any {
        guard amount <= balance else {
            print("not enough")
            return false
        }
        balance -= amount
        return balance
    }
}
// Create a Shape base class and Triangle/Square subclasses overriding an area() method.
class Shape {
    func area() -> Double {
        return 0.0
    }
    
    
}
class Triangle: Shape {
    var base: Double
    var heigh: Double
    init(base: Double, heigh: Double) {
        self.base = base
        self.heigh = heigh
    }
    override func area() -> Double { // ////MARK: Polymorphism
        return 0.5 * base * heigh
    }
}

class Square: Shape {
    var side: Double
    init(side: Double) {
        self.side = side
    }
    override func area() -> Double { // ////MARK: Polymorphism
        return side * side
    }
}
let triangle = Triangle(base: 6, heigh: 10)
let square = Square(side: 5)

print("Triangle area: \(triangle.area())")
print("Square area: \(square.area())")


// Demonstrate reference semantics by assigning one instance to multiple variables and modifying it.
//3.Classes refrence type usage
class DogClass {
    var name: String
    var age: Int
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    func updateRersonDetails(AnotherName:String, AnotherAge: Int){
        self.name = AnotherName
        self.age = AnotherAge
    }
}


var pet1 = Dog(name: "Rex", age: 5)

var pet2 = pet1
pet2 = Dog(name: "Max", age: 10)
print("pet1",pet1)




struct Dog {
    var name: String
    var age: Int
    
    mutating func updateRersonDetails(AnotherName:String, AnotherAge: Int){
        self.name = AnotherName
        self.age = AnotherAge
    }
    
}


var petS1 = Dog (name: "Rex", age: 5)

var petS2 = pet1
petS2 = Dog(name: "Max", age: 10)

print("petS1",petS1)


//4.Structs
//Create a struct Book with properties title and author and a method description().


struct Book {
    var title: String
    var author: String
    
    func description() -> String {
        return "Book title: \(title), Author: \(author)"
    }
}

let book = Book(title: "The Alchemist", author: "Paulo Coelho")
print(book.description())

// Make a struct Temperature with a computed property converting Celsius to Fahrenheit

struct Temperature {
    var celcius: Double
    var fahrenheit: Double {
        return (celcius * 9.0 / 5.0) + 32.0
    }
}
// Build a struct Vector2D with methods to add and subtract two vectors
struct Vector2D {
    var x: Double
    var y: Double
    
    func add(_ vector: Vector2D) -> Vector2D {
        return Vector2D(x: self.x + vector.x, y: self.y + vector.y)
    }
    
    func subtract(_ vector: Vector2D) -> Vector2D {
        return Vector2D(x: self.x - vector.x, y: self.y - vector.y)
    }
}
let v1 = Vector2D(x: 1.0, y: 2.0)
let v2 = Vector2D(x: 3.0, y: 4.0)
let sum = v1.add(v2)
let difference = v1.subtract(v2)
print("Sum: \(sum)")
print("Difference: \(difference)")



