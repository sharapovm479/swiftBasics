//: [Previous](@previous)

import Foundation

//Assignment 9 — Swift Playground Dependency Injection
//1. Create a DataService protocol.
//    1. Implement NetworkService and MockService some dummy function,
//    2. Inject service into DataManager via initializer.,
//    3. Show switching between live and mock.,
//2. ,
//Dependency Inversion 1.Constructor injection 2.Property injection, 3.Method Injection usage Copy-on-Write (CoW)
//1. Create a = [1,2,3], b = a.
//    1. Print buffer addresses of both.,
//    2. Mutate b and print addresses again.,
//    3. Show that class elements inside arrays still share reference.,
//2. ,
//ARC (Strong / Weak / Unowned)
//1. Create a Manager class with deinit.
//    1. Show deallocation with strong reference.,
//    2. Demonstrate weak reference (becomes nil).,
//    3. Demonstrate unowned reference (must outlive owner).,
//2. ,
//Retain Cycles
//1. Create class A and class B holding strong refs to each other → no deinit.
//    1. Fix by making one side weak.
//


/*
 DepedeancyInjection - DI - Whatever the class,struct needs it to perfom the functionlity we should be able to pass it hru from outside, instead of hardcoding things locally
 
 1.Constructor injection / Intilizer injection- when u pass ur depdeancy in Constructor of that class then it means
 2.Property injection - When u inject ur depdeancy from outside by assigning a value to a property in that class then
 3.Method Injection / function injection - when u have depdeancy which is very speific to that funciton and not anywhere outside then it is
 
 Depedeancy Inversion- when u pass your depdeancy as a protocol then it becomes Depedeancy Inversion
 */

// MARK: - PART 1 — Dependency Injection (NO Inversion)
//      Concrete types only (tight coupling)


final class NetworkService {
    func FetchItems() -> [String] {
        // print("[NetworkService] FetchItems()") // Debug
        return ["Live_A", "Live_B", "Live_C"]
    }
}
// // Test:
// let Net = NetworkService()
// print(Net.FetchItems())

final class DataManagerDIConstructor {
    private let Service: NetworkService      // concrete type
    init(Service: NetworkService) {
        self.Service = Service
        // print("[DataManagerDIConstructor] Injected:", type(of: Service)) // Debug
    }
    func LoadItems() -> [String] {
        let Items = Service.FetchItems()
        // print("[DataManagerDIConstructor] Items:", Items) // Debug
        return Items
    }
}
// // Test:
// let ManagerCtor = DataManagerDIConstructor(Service: NetworkService())
// print("CtorItems:", ManagerCtor.LoadItems())

final class DataManagerDIProperty {
    var Service: NetworkService?             // inject later (be careful!)
    func LoadItems() -> [String] {
        let Items = Service?.FetchItems() ?? []
        // print("[DataManagerDIProperty] Items:", Items) // Debug
        return Items
    }
}
// // Test:
// let ManagerProp = DataManagerDIProperty()
// ManagerProp.Service = NetworkService()
// print("PropItems:", ManagerProp.LoadItems())

func RenderListConcrete(Using Service: NetworkService) -> String { // Method Injection
    let Items = Service.FetchItems()
    // print("[RenderListConcrete] Items:", Items) // Debug
    return "Rendered(\(Items.count))"
}
// // Test:
// print(RenderListConcrete(Using: NetworkService()))

// limitation without DIP):
// No easy swapping because everything is tied to NetworkService.


// MARK: - PART 2 — Dependency Inversion (DIP + DI)
//      Protocol boundary (loose coupling, easy to swap)
/*
 Depedeancy Inversion- when u pass your depdeancy as a protocol then it becomes Depedeancy Inversion
 O-- open close principle-
SOLID
 */

// dependency inversion
protocol DataService {
    func FetchItems() -> [String]
}

// Live device
final class LiveNetworkService: DataService {
    func FetchItems() -> [String] {
        // print("[LiveNetworkService] FetchItems()") // Debug
        return ["Live_A", "Live_B", "Live_C"]
    }
}

// Mock device
final class MockNetworkService: DataService {
    func FetchItems() -> [String] {
        // print("[MockNetworkService] FetchItems()") // Debug
        return ["Mock_1", "Mock_2"]
    }
}

// Constructor Injection (now via protocol)
final class DataManagerDIP_Constructor {
    private let Service: DataService
    init(Service: DataService) {
        self.Service = Service
        // print("[DataManagerDIP_Constructor] Injected:", type(of: Service)) // Debug
    }
    func LoadItems() -> [String] {
        let Items = Service.FetchItems()
        // print("[DataManagerDIP_Constructor] Items:", Items) // Debug
        return Items
    }
}
// // Test:
// let LiveCtor = DataManagerDIP_Constructor(Service: LiveNetworkService())
// print("DIP_Ctor_Live:", LiveCtor.LoadItems())
// let MockCtor = DataManagerDIP_Constructor(Service: MockNetworkService())
// print("DIP_Ctor_Mock:", MockCtor.LoadItems())

// Property Injection (via protocol)
final class DataManagerDIP_Property {
    var Service: DataService?
    func LoadItems() -> [String] {
        let Items = Service?.FetchItems() ?? []
        // print("[DataManagerDIP_Property] Items:", Items) // Debug
        return Items
    }
}
// // Test:
// let DipProp = DataManagerDIP_Property()
// DipProp.Service = MockNetworkService()
// print("DIP_Property_Mock:", DipProp.LoadItems())

// Method Injection (via protocol)
func RenderListProtocol(Using Service: DataService) -> String {
    let Items = Service.FetchItems()
    // print("[RenderListProtocol] Items:", Items) // Debug
    return "Rendered(\(Items.count))"
}
// // Test:
// print(RenderListProtocol(Using: LiveNetworkService()))

// Demo: switch easily between live and mock
func DemoSwitchingService(UseMock: Bool) -> [String] {
    let Chosen: DataService = UseMock ? MockNetworkService() : LiveNetworkService()
    let Manager = DataManagerDIP_Constructor(Service: Chosen)
    return Manager.LoadItems()
}
// // Test:
// print("Switch_Live:", DemoSwitchingService(UseMock: false))
// print("Switch_Mock:", DemoSwitchingService(UseMock: true))

// MARK: - 2. Copy-on-Write (CoW)

//Copy-on-Write (CoW)
//1. Create a = [1,2,3], b = a.
// in class var num = 10
//var array1 = [1,2,4,5] // value types and gets stored on stack memory  //0x1000
//
//var array2 = array1 // //0x1000
//
//array1.append(6) //after this modification
//array1.append(7) //after this modification
//array1.append(8) //after this modification
//
//func printArrayAddress(array:[Int]){
//    withUnsafePointer(to:array ){ ptr in
//        print(ptr)
//    }
//}
//
//print(printArrayAddress(array: array1))
//print(printArrayAddress(array: array2))
//
//
//struct Point{
//    var x:Int
//    var y:Int
//}
//var point1 = Point(x: 1, y: 2)
//var point2 = point1
//
//point2.x = 4

//var a = [1, 2, 3]
//var b = a
//
////1. Print buffer addresses of both.
//print("Before")
//print("Before a: \(a), address: \(Unmanaged.passUnretained(a as AnyObject).toOpaque())")
//print("Before b: \(b), address: \(Unmanaged.passUnretained(b as AnyObject).toOpaque())")
//
////2. Mutate b and print addresses again.
//b.append(4)
//print("After")
//print("After a: \(a), address: \(Unmanaged.passUnretained(a as AnyObject).toOpaque())")
//print("After b: \(b), address: \(Unmanaged.passUnretained(b as AnyObject).toOpaque())")

// Print memory address
func address(_ object: UnsafeRawPointer) -> String {
    let address = Int(bitPattern: object)
    return NSString(format: "%p", address) as String
}

struct A {
    var value: Int = 0
}

//Default behavior(COW is not used)
var a1 = A()
var a2 = a1

//different addresses
print(address(&a1))
print(address(&a2))

//COW for a2 is not used
a2.value = 1
print(address(&a2))


//Value type with COW (Collection)

//collection(COW is realized)
var collection1 = [A()]
var collection2 = collection1

//same addresses
print("address(&collection1)",address(&collection1)) // 0x600000c07410
print(address(&collection2)) // 0x600000c07410

//COW for collection2 is used
collection2.append(A())
print("address(&collection2)",address(&collection2)) // 0x600000c0e5d0




// MARK: - 3. ARC (Strong / Weak / Unowned)

//ARC (Strong / Weak / Unowned)
//1. Create a Manager class with deinit.


class Manager {
    var name: String
    weak var assistant: Assistant?
    
    init(name: String) {
        self.name = name
        print("Manager \(name) initialized")
    }
    
    deinit {
        print("Manager \(name) deinitialized")
    }
}

class Assistant {
    var name: String
    unowned let manager: Manager
    
    init(name: String, manager: Manager) {
        self.name = name
        self.manager = manager
        print("Assistant \(name) initialized")
    }
    
    deinit {
        print("Assistant \(name) deinitialized")
    }
}

//1. Show deallocation with strong reference.

var manager1: Manager? = Manager(name: "John")
var strongRef = manager1

manager1 = nil
strongRef = nil


//2. Demonstrate weak reference (becomes nil).

var manager2: Manager? = Manager(name: "Alice")
weak var weakRef = manager2
manager2 = nil
print(weakRef == nil ? "nil" : "not nil")

//3. Demonstrate unowned reference (must outlive owner).

var manager3: Manager? = Manager(name: "Bob")
unowned var assistant: Assistant? = Assistant(name: "Tom", manager: manager3!)
manager3?.assistant = assistant

assistant = nil // Assistant deallocated
manager3 = nil // Manager deallocated

// MARK: - 4. Retain Cycles

//Retain Cycles
//1. Create class A and class B holding strong refs to each other → no deinit.

class ClassA {
    var name: String
    var classB: ClassB?
    
    init(name: String) {
        self.name = name
        print("ClassA \(name) initialized")
    }
    
    deinit {
        print("ClassA \(name) deinitialized")
    }
}

class ClassB {
    var name: String
    var classA: ClassA?
    
    init(name: String) {
        self.name = name
        print("ClassB \(name) initialized")
    }
    
    deinit {
        print("ClassB \(name) deinitialized")
    }
}

print("Retain cycle without deinit")
var objA: ClassA? = ClassA(name: "A1")
var objB: ClassB? = ClassB(name: "B1")
objA?.classB = objB
objB?.classA = objA // Strong reference cycle created
objA = nil
objB = nil
print("Objects not dealloc due to retain cycle")




//1. Fix by making one side weak.
// Fixed version with weak reference
class ClassC {
    var name: String
    weak var classD: ClassD? // weak to break cycle
    
    init(name: String) {
        self.name = name
        print("ClassC \(name) initialized")
    }
    
    deinit {
        print("ClassC \(name) deinitialized")
    }
}

class ClassD {
    var name: String
    var classC: ClassC?
    
    init(name: String) {
        self.name = name
        print("ClassD \(name) initialized")
    }
    
    deinit {
        print("ClassD \(name) deinitialized")
    }
}

print("Fixed retain cycle w weak reference:")
var objC: ClassC? = ClassC(name: "C1")
var objD: ClassD? = ClassD(name: "D1")
objC?.classD = objD
objD?.classC = objC
objC = nil
objD = nil

