//: [Previous](@previous)

import Foundation

//: [Previous](@previous)

import Foundation

/*
 AssociatedType - this is used for protocols to define a placeholder name for the type that can be used as a part for protocol
 */

protocol Shape{
    associatedtype AreaType
    func calculateArea() -> AreaType
}
//func drawShape(shapeType:Shape){
//
//}
struct Square: Shape{
    var side: Int
    typealias AreaType = Int
    
    func calculateArea() -> AreaType{
        return side * side
    }
}

let sq = Square(side: 4)
print(sq.calculateArea())


struct Circle: Shape{

    var radius: Double
    typealias AreaType = Double

    func calculateArea() -> Double {
        return Double.pi * radius * radius
    }
    
}
let c1 = Circle(radius: 3)
print(c1.calculateArea())

protocol Conatiner{
    associatedtype Element
    mutating func addElements(_ element:Element)
    mutating func removeElement() -> Element?
}
struct IntStack:Conatiner{
   
    private var items: [Element] = []
    typealias Element = Int
    
    
    mutating func addElements(_ element: Int) {
        items.append(element)
    }
    
    mutating func removeElement() -> Int? {
        items.popLast()
    }
    
    func displayStack() -> [Int] {
        return items
    }
}

var s1 = IntStack()
s1.addElements(1)
s1.addElements(2)
s1.addElements(3)
print(s1.displayStack())


protocol APIRequest{
    associatedtype Response
    var endpoint: String {get}
    
}

struct UserListRequest: APIRequest{
    typealias Response = [Int]
    
    var endpoint: String = "/users"
}


struct FruitRequest: APIRequest{
    typealias Response = String
    var endpoint: String = "/fruit"
}

class APIManager{
    func getData<T:APIRequest>(_ request : T) -> T.Response{
        
        if request.endpoint == "/users"{
            return [1,2,3] as! T.Response
        }else{
            return "abc" as! T.Response
        }
    }
}

let apiManger = APIManager()
let usersList = apiManger.getData(UserListRequest())
let fruitList = apiManger.getData(FruitRequest())
