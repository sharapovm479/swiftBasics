//: [Previous](@previous)

import Foundation

//Assignment 8 In Swift playgorund have multiple examples to show usage of below:
//1. Initializers
//    1. Create a Book struct with a custom initializer that sets a default "Unknown" author if none is provided.,
struct Book {
    var title: String
    var author: String
    
    init(title: String, author: String = "Unknown") {
        self.title = title
        self.author = author
    }
    
}
let testBook = Book(title: "The Alchemist",author: "Paulo Coelho")
print(testBook)
//    2. Build a Circle struct with two initializers: one for radius, another for diameter (delegating to radius).,
struct Circle {
    var radius: Double
    
    init(radius: Double) {
        self.radius = radius
    }
    
    init(diameter: Double) {
        self.radius = diameter / 2
    }
}
let testCircle1 = Circle(radius: 5.0)
let testCircle2 = Circle(diameter: 10.0)
print(testCircle1)
print(testCircle2)
//    3. Create a failable initializer for an Email struct that returns nil if the string doesn’t contain "@".,
struct Email {
    let address: String
    
    
    init?(_ address: String) {
        guard address.contains("@") else { return nil } // failable init return nil if invalid
        self.address = address
    }
}
if let validEmail = Email("johndoe@example.com") {
    print(validEmail)
} else {
    print("Invalid email format")
}

//    4. Make a Car class that has a designated initializer (brand, doors) and a convenience initializer (brand) that defaults doors to 4.,
class Car {
    var brand: String
    var doors: Int
    init(brand: String, doors: Int) {
        self.brand = brand
        self.doors = doors
    
    }
    convenience init(brand: String) {
        self.init(brand: brand, doors: 4)
    }
}

//class Food {
//    var name: String
//    init(name: String) {
//        self.name = name
//    }
//    convenience init() {
//        self.init(name: "[Unnamed]")
//    }
//}




let testNonConvenienceCar = Car(brand: "Toyota",doors: 2)
print(testNonConvenienceCar)
// below uses convenience init
let testConvenienceCar = Car(brand: "Honda")// did not declare doors
print("testConvenienceCar.brand",testConvenienceCar.brand)
print("testConvenienceCar.doors",testConvenienceCar.doors) // here we used convenienceCar because we got 4


//    5. Define a base class Shape with a required init(sides:) and implement it in a subclass Triangle.,

//2. , from docs.swift: must also write the required modifier before every subclass implementation of a required initializer, to indicate that the initializer requirement applies to further subclasses in the chain. You don’t write the override modifier when overriding a required designated initializer:

class Shape {
    let sides: Int
    let name: String
    required init(sides: Int) {
        self.sides = sides
        self.name = "Shape"
    }
}
class Triangle: Shape {
    let rightAngleIndex: Bool
    
    required init(sides: Int) { // because we included sides in init in Shape class, our subclass Trianlge must have sides as we used required init
        self.rightAngleIndex = false
        super.init(sides: sides)
    }
}
let triangle = Triangle(sides: 3)
print(triangle.sides)
//3. Error Handling , Do try catch , try , try!, throw , throws,
//2. Demonstrate do/try/catch by handling both safe and error cases of your functions.
//    1. Write a function sqrt(of:) throws that throws an error if input is negative.,

//    3. Use try? with a throwing function to return an optional result safely.,


enum MathError: Error {
    case negativeNumber
    case divisionByZero
}

func sqrt(of number: Int) throws -> Int {
    if number < 0 {
        print("MathError.negativeNumber",MathError.negativeNumber)
        throw MathError.negativeNumber
    }
    if number == 0 { // cannot divide by zero
        print("MathError.divisionByZero",MathError.divisionByZero)
        throw MathError.divisionByZero
    }
    return Int(sqrt(Double(number)))
}

try sqrt(of: -16)

func DoTryCatch() throws {
    let testNumber = [16, 25, 36, 49, 64, -10]
    
    for num in testNumber {
        do {
           let res = try sqrt(of: num)
            print("res",res)
        } catch {
            print("caught negative num")
        MathError.negativeNumber
        }
    }
    
}
print("try DoTryCatch()",try DoTryCatch())

//    4. Create a NetworkError enum
//and a fetchData(from:) throws function that validates a URL and simulates "Data from URL" or throws errors.,

enum NetworkError: Error {
    case invalidURL
    case serverError(code:Int)
    case noData
    case decodingFailed
}
func fetchData(from url: URL) throws -> Data {
    guard !url.absoluteString.isEmpty || url.scheme != nil || url.absoluteString.hasPrefix("http://") || url.absoluteString.hasPrefix("https://") else {
        print("NetworkError.invalidURL",NetworkError.invalidURL)
        throw NetworkError.invalidURL
    }
    return Data()

}
try fetchData(from: URL(string: "invalid url")!)




    



























