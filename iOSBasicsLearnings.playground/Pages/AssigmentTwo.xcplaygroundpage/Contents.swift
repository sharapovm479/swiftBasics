import Foundation



//MARK: Assignment 2
//In Swift playgorund have multiple examples to show usage of below:
//1.functions- differnt types
//2.collections- Array, set, dictionary
//3.Write a function square(number:) that returns the square of an Int.
//4.Create a function greet(user:atTime:) that prints different messages based on the time.
//5.Build a function merge(arrays:) that takes variadic [Int] arrays and returns a single merged sorted array.
//6.Create an array of strings for your top 3 favorite apps and print them in reverse order.
//Use a set to store unique programming languages from a list containing duplicates.
//
//Create a dictionary mapping product IDs (String) to stock counts (Int). Update stock for a product.
//
//Tomorrow in classroom you need to explain your written code, so dont rush in finishing the assignment, take your time and do it throughly.
//Once Completed this and push to code to githib and share link of it in this group itself.
//@Priyanka for now focus on doing small code and learning swift topics like-
//1.Constants, variables
//2.Functions 3.collections



//MARK: Functions

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
//
//
//func sumOfTwo(_ x:Int,_ y:Int) -> Int {
//    return x+y
//}
//print(sumOfTwo(1,2)) // since we added underscore inside parmameters we do not need to add x and y
//
//
//func square(number: Int) -> Int {
//    return number * number
//}
//
//
////Inout paramters, (means could be incremenated, modified )
//func increment (value: inout Int) {
//    value += 1
//}
//var count = 10
//increment(value: &count)
//
//
//
//func doSpecificTask(name:String, age:Int = 1, gender:Bool) -> String{
//    return "Hello \(name), you are \(age) years old and \(gender ? "Male" : "Female")"
//}
//
//print(doSpecificTask(name: "Swift", age: 10, gender: true))
////argument labels & paramter names
//func muliply(_ x:Int, _ y:Int) -> Int {
//return x * y
//}
//print (muliply(5, 2))
//
////Default paramter function
//func greet (name:String, employeeId:Int = 1){
//print ("Welcome \(name) to team, your employeeld is \(employeeId)")
//}
//greet (name: "John")
//greet (name: "Mark", employeeId: 25)

//Closures

//{ (parameters) -> returnType in
//   // statements
//}

var closureTest = {
    print("Hello World")
}
closureTest() // to call
// built in closers

// closure with a parm
let greetTheWorld = { (name: String)  in
    print("Hello, \(name).")
}

// closure call
greetTheWorld("World") // Hello World












// MARK: Collections


////import DequeModule
//var MyDeque: Deque<Int> = [] // got the files from offical apple github: https://github.com/apple/swift-collections/tree/main/Sources/DequeModule
//MyDeque.append(1)
//MyDeque.append(2)
//MyDeque.append(3)
//MyDeque.append(4)
//MyDeque.append(5)
//MyDeque.prepend(6)
//print("before pops",MyDeque)
//print(MyDeque.popLast()!)
//print(MyDeque.popFirst()!) // regular array would be Big(n), Dequeu is Big(1) for popLast, popFirst, append and prepend
//print(MyDeque)
//// need to upload more files to make it work from offical apple
///
///
///










// Dictionary(hashmap)
 //O(1) = search, insertion, deletion

// empty map
var emptyMap: [String: Int] = [:]

var map: [String: Int] = ["apple": 2, "banana": 5, "orange": 4]

map["apple"] 
map["pineapple"] 
map["pineapple"] = 10
// classic two sums prob
var twoSumArr = [2, 7, 11, 5]
var twoSumMap: [Int: Int] = [:]
var target: Int = 9

for (index, value) in twoSumArr.enumerated() {
    let complement: Int = target - value
    if twoSumMap[complement] != nil {
        print("Found!")
    }
    twoSumMap[value] = index
}
//
//
// Array
// Array= time comlexity when appending, removing in the begening of array is O(N) thus for queue better to use DequeModule which is O(1)

var myArray: [Int] = []
myArray.append(1) // adds at the end
myArray.append(2)
myArray.append(3)
myArray.append(4)
myArray.append(5)

myArray.removeLast()

myArray.remove(at: 0) // O(N)
// or
myArray.removeFirst()

myArray.insert(6, at: 2)// not efficient

print(myArray)

var anyTypeArray: [Any] = []
anyTypeArray.append(1)
anyTypeArray.append("hello")
anyTypeArray.append(true)
print(anyTypeArray)




// Set
// cannot have duplicates, cannot be sorted, instant look up(O(1))

var set: Set<Int> = []
set.insert(1)
set.insert(1) // cannot have duplicates
set.insert(2)
set.insert(3)
set.insert(4)
set.insert(5)

set.contains(4) // should be true
print(set)
