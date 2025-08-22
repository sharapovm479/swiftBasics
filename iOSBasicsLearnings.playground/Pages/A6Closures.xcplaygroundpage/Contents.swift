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
    
    DispatchQueue.global(qos: .default).asyncAfter(deadline: .now() + 5) {
        
        task()
        
        
    }
    print("after Task")
}
doLater {
    print("Executed after 5 second!")
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
    print("Executed after 2 second!")
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














//EXTRA: not part of hw Assignment6


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







// MARK: - Bitcoin Price Class

class BitcoinPrice {
  
    var symbol = "BTC"

    var latestPrice: Double = 0
    
    //  using static as static properties belong to the type itself rather than instances, meaning we can access BitcoinPrice.apiURL without creating an object, and all instances share the same URL, so we avoid duplicating the string in memory and can use Self.apiURL in instance methods
    static let apiURL = "https://min-api.cryptocompare.com/data/histominute?fsym=BTC&tsym=USD&limit=1"
    
    //  creating a computed property because computed properties calculate their value on-demand rather than storing it
    var priceInCents: Int {

        return Int(latestPrice * 100)
    }
    
    //  using @escaping because by default (non-escaping), but our completion handler will be stored and called later when the network request completes, which is after fetchPrice returns, so @escaping tells Swift to keep the closure alive
    func fetchPrice(completion: @escaping (Error?) -> Void) {
        //  using optional binding, guard let to safely
        guard let url = URL(string: Self.apiURL) else {
            //  logging the error
            print("Invalid URL")
            //  creating an NSError because the completion handler expects an Error? parameter and NSError is a concrete error type we can create with custom messages, so the caller knows what went wrong without us defining custom error types
            completion(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
           
            return
        }
        
        //  logging the URL because seeing exactly what endpoint we're calling helps debug issues like wrong parameters or API version changes
        print("Fetching Bitcoin price from: \(url)")
        
        //  fetching data from a URL, returning the raw bytes, HTTP response, and any error, so we can download the JSON data from the API
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            //  checking error
            if let error = error {
                //  logging the specific error
                print("Network Error: \(error)")
                //  passing the error through to our completion handler because the caller needs to know the request failed and potentially show an error to the user or retry, so we propagate the error up
                completion(error)
 
                return
            }
            
            //  using guard let to unwrap data
            guard let data = data else {
           
                print("No data received")
                //  creating a custom error with a descriptive domain
                completion(NSError(domain: "No data", code: 0, userInfo: nil))
                
                return
            }
            
        
            print("Data received: \(data.count) bytes")
            
        
            do {
                //  using try with JSONSerialization because it's a throwing function that will throw an error if the data isn't valid JSON
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    //  printing the entire JSON response because during development we need to see the exact structure returned by the API to understand how to parse it, so we can write the correct parsing logic
                    print("JSON Response: \(json)")
                    
                    //  accessing json["Data"] because the CryptoCompare API returns price data inside a "Data" key that contains an array of price points, so we need to drill down into this structure
                    if let dataArray = json["Data"] as? [[String: Any]],
                       //   get the current Bitcoin price rather than an old one by using .last
                       let lastData = dataArray.last,
                       //  data point has open, high, low, and close prices, and close represents the final price which we need
                       let closePrice = lastData["close"] as? Double {
                        
                        //  using self.latestPrice because we're inside a closure which captures self, and we need to explicitly use self to access instance properties from within closures, so Swift knows we're referring to the class property not creating a local variable
                        self.latestPrice = closePrice
                        //  using the asCurrency computed property because it formats the raw double as a currency string with proper decimal places and dollar sign, so the price displays nicely for users
                        print("Bitcoin price: $\(closePrice.asCurrency)")
                        //  accessing our computed property priceInCents because we want to demonstrate that it correctly converts the price to cents, so we can verify our computed property logic works
                        print("In cents: \(self.priceInCents)")
                        
                        //  calling completion with nil because in Swift's error handling convention, nil error means success, so the caller knows the operation completed successfully and can access btc.latestPrice
                        completion(nil)
                    } else {
                       
                        print("Failed to parse price from JSON")
                        
                        completion(NSError(domain: "Parse error", code: 0, userInfo: nil))
                    }
                }
            } catch {
                //  catching JSON parsing exceptions
                print("JSON parsing error: \(error)")
                //  display error messages
                completion(error)
            }
        }
        
        //  calling task.resume() because URLSession creates all tasks in a suspended state by default for performance reasons, allowing us to configure them before starting, so nothing will happen until we explicitly call resume() to begin the network request
        task.resume()
    }
}

// MARK: - Extension for Double formatting
//  using an extension because extensions in Swift let us add functionality to existing types even ones we don't own like Double, without modifying their original implementation
extension Double {
    //  creating a computed property instead of a method so we can write price.asCurrency instead of price.asCurrency(), making the code more readable
//    func asCurrency() -> String {
//        return String(format: "$%.2f", self)
//    }
    var asCurrency: String {
        //  using String(format:) with %.2f so prices display as $123.45 not $123.4 or $123.456
        return String(format: "$%.2f", self)
    }
}

// MARK: - Main Execution


let btc = BitcoinPrice()

var cache = MemoryCache()

//  calling fetchPrice with a trailing closure because Swift allows us to write closures after the function call parentheses when the closure is the last parameter
btc.fetchPrice { error in

    if let error = error {

        print("Failed",error)
    } else {

        print("very nice, Success")
    
        print("btc price \(btc.latestPrice.asCurrency)")
        
        //  calling cache.save because we want to store the fetched price in our in-memory cache to avoid making repeated API calls, so we can retrieve it quickly later
        cache.save(key: "BTC", value: btc.latestPrice)
        
        //  immediately loading from cache because we want to verify our caching mechanism works correctly by saving and then retrieving, so we can confirm both operations function properly
        if let cachedPrice = cache.load(key: "BTC") {

            print("Retrieved from cache: \(cachedPrice.asCurrency)")
        }
    }
}
