//: [Previous](@previous)

import Foundation

//Assignment 5
//In Swift playgorund have multiple examples to show usage of below:
//1.Properties : Stored,  Computed , Static
//
//2.extension usage
//
//3.Protocols
//  
//Define a protocol Playable with a method play(). Make Music and Video structs conform to it.
//Create a protocol Shape with an area() method. Implement Circle and Rectangle.
//Make a protocol Cacheable with methods save(key:value:) and load(key:). Implement it with a Dictionary.
//Use protocol extensions to give Greetable a default sayHi() method.


// protoclos defines blueprints of methods and properites, protocols enable reuse and abstraction across structs, classes, enums.

// protocols let us create memroy-safe delegate design, delegates are refernces which could cause memory leaks, retain cycles(two strong pointers that are pointing to each other and ARC does not know which pointer to drop, thus one of the pointer must be weak so ARC knows which one to drop fully de alocate the memory). by using protocols we could avoid retain cycles


//protocol ListDelegate: AnyObject {
//    func didUpdate(_ item: String)
//}
//final class DetailVC {
//    weak var delegate: ListDelegate?
//    func save(item: String) {delegate?.didUpdate(item)}
//}

// protocols are useful for testing

// lazy var could save memory, memory for heavy tasks,  get allocated only when the property get accessed
//lazy var heavyImage: UIImage = {
//    
//}

// static keyword in swift is used to define type property and type methos without creating an object, static propreties and methods cannot be overridden. for exmple we if we have some specific value or methods that we know will stay the same then we would want to use static, such as PI number, we know pi will alawasy be 3.14 or some apis, as api usually do not change




//class BitcoinPrice {
//    var symbol = "BTC"
//    var latestPrice: Double = 0
//    // static proprety to avoid concurency issues
//    
//    static let apiURL = "https://min-apicryptocompare.com/data/histominute?fsym=BTC&tsym=USD&limit=1" // / here we are declaring static proprety apiURL without creating an object we were able to access apiURL(BitcoinPrice.apiURL) also we cannot override static methods and propretires
//
//    var pirceInCent: Int {
//        return Int(latestPrice * 100)
//    }
//    
//    // fetch real data prices, no async
//    func fetchPrice(completion: @escaping (Error?) -> Void) {
//        guard let url = URL(string: BitcoinPrice.apiURL) else { // here we were able to access to apiURL without creating an object we were able to access apiURL(BitcoinPrice.apiURL) also we cannot override static methods and propretires
//
//            return
//        }
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("Error",error)
//                return
//            }
//            guard let data = data else {
//                print("no data recieved")
//                return
//            }
//            if let json = try? JSONSerialization.jsonObject(with: data) as? [String:Any],
//               let dataArray = json["Data"] as? [[String:Any]] {
//                
//               let lastData = dataArray.last,
//               let closePrice = lastData["close"] as? Double {
//                   self.latestPrice = closePrice
//                   
//                   print("Bitcoin price is: \(closePrice)")
//                   print("In cents: \(self.pirceInCent)")
//                   }
//                
//            }
//        
//
//        }
//    }
//    
//    
//}


//Define a protocol Playable with a method play(). Make Music and Video structs conform to it.
protocol Playable {
    func play()
}
struct Music: Playable {
    
    func play() {
        print("playing music")
    }
}

struct Video: Playable {
    func play() {
        print("playing video")
    }
}

let song = Music()
song.play()

let movie = Video()
movie.play()
//Create a protocol Shape with an area() method. Implement Circle and Rectangle.


protocol Shape  {
    func area() -> Double
    
}

struct Circle: Shape {
    let radius: Double
    
    func area() -> Double {
        return .pi * radius * radius
    }
}

struct Rectangle: Shape {
    let length: Double
    let width: Double
    
    func area() -> Double {
        return length * width
    }
}

let circle = Circle(radius: 5)
print(circle.area())

let rectangle = Rectangle(length: 10, width: 20)
print(rectangle.area())

//Make a protocol Cacheable with methods save(key:value:) and load(key:). Implement it with a Dictionary.
//
protocol Cacheable {
    mutating func save(key:String, value: Double)
    func load(key: String) -> Double?
    
}
struct MemoryCache: Cacheable {
    private var cache: [String: Double] = [:]
    mutating func save(key: String,value: Double) {
        cache[key] = value
        print("Saved\(value) key: \(key)")
        print(cache)
    }
    
    

    
    func load(key: String) -> Double? {
        return cache[key]
    }
}
var cache = MemoryCache()
cache.save(key: "bitcoin", value: 1000000)
let price = cache.load(key: "bitcoin")

//Use protocol extensions to give Greetable a default sayHi() method.

protocol Greetable {
    var name: String { get }
    
}
extension Greetable {
    func sayHi() {
        "Hola privet, my name is \(name)"
    }
}

struct Person: Greetable {
    var name: String
}
let person = Person(name: "Artem")
print(person.sayHi())





