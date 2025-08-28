//: [Previous](@previous)

import Foundation


//Assignment 10 — Swift Playground
//
//Capture List
//    •    Create a counter that starts from an initial start value.
//    •    Assign a closure that captures start by value (capture list) and prints it each time it runs.
//    •    Change the outer start afterward and prove the closure still prints the original captured value.
//    •    Create a second closure that captures a mutable local variable by value ([copy = local]) and show the original can change without affecting copy.
//
//Closure with Capture List for weak self
//    •    Design a Downloader (or Timerowner) class with a closure property onFinish.
//    •    Assign onFinish using [weak self] so the object can deallocate if the user “navigates away”.
//    •    Show: with weak capture → object deallocates; without it → retain cycle risk.
//
//GCD —
//Show with differnt examples how to use
//1.Main Queue
//2.Custom Queue- serial and concurrent queue usage
//Global queues and use of differnt QOS





//   • Create a counter that starts from startValue
//   • Closure captures startValue by value ([StartCopy = startValue])
//   • Change outer startValue later → closure still prints original snapshot

var startValue = 5

let counterClosure: () -> Void = { [StartCopy = startValue] in
    // print("counterClosure captured:", StartCopy)
}

startValue = 999  // change the outer value after closure is created
 counterClosure() // → will still use StartCopy (5), not 999




// Capture List with local Mutable Variable Copy
//   • Capture a mutable local variable by value [Copy = local]
//   • Prove changing local later does NOT change Copy inside closure


func makeCopyClosureExample() -> (() -> Void) {
    var local = 42
    let showCopy: () -> Void = { [Copy = local] in // capture list
        // print("Inside closure → Copy =", Copy)
    }
    local = 123 // mutate after we created the closure
    // print("Outside closure → local =", local)
    return showCopy
}

let CopyDemo = makeCopyClosureExample()
// CopyDemo()  // Inside: Copy = 42; Outside was changed to 123




// Closure with Capture List for [weak self]
//   • Design a Timerowner with a closure property `onFinish`
//   • Assign using [weak self] so it can deallocate if "navigates away"
//   • Show: strong capture = retain cycle risk; weak capture = dealloc OK


final class Timerowner {
    var onFinish: (() -> Void)?
    var name: String

    init(name: String) {
        self.name = name
         print("Init:", name)
    }

    deinit {
         print("Deinit:", name)
    }

    // Strong capture - retain cycle risk
    func setupStrongCapture() {
        onFinish = {
            // print("[Strong] Running onFinish for \(self.name)")
        }
    }

    // better approuch: Weak capture (no cycle: closure does not strongly hold self)
    func setupWeakCapture() {
        onFinish = { [weak self] in
             print("[Weak] Running onFinish for \(self?.name ?? "nil")")
        }
    }
}

// STRONG capture (retain cycle risk)
func showRetainCycleRisk() {
    var owner: Timerowner? = Timerowner(name: "Strongowner")
    owner?.setupStrongCapture()
    owner?.onFinish?()
    owner = nil // With strong capture, deinit will NOT run (cycle)
    // print("After nil Strongowner (retain cycle likely)")
}

//  WEAK capture (ARC can dealloc)
func showWeakCaptureDeallocates() {
    var owner: Timerowner? = Timerowner(name: "Weakowner")
    owner?.setupWeakCapture()
    owner?.onFinish?()
    owner = nil // With weak capture, deinit runs (no cycle)
    // print("After nil Weakowner (deinit should have happened)")
}

// Toggle these to see behavior:
 showRetainCycleRisk()
 showWeakCaptureDeallocates()



// GCD — Main Queue, Custom Queues (Serial/Concurrent), Global + QoS
//
//   • Main = main lane for UI
//   • Serial = one task at a time
//   • Concurrent =  parallel, async tasks
//   • Global + QoS = flexible,



// 4.1 Main Queue (UI work)


func doMainQueueWork() {
    DispatchQueue.main.async {
        // print("Main Queue: UI updates on main thread?", Thread.isMainThread)
        // Example: update UI elements here
    }
}
// doMainQueueWork()



// 4.2 Custom Queue — Serial (one by one)


let serialQueue = DispatchQueue(label: "com.example.serialQueue")

func doSerialQueueWork() {
    serialQueue.sync {
        print("Serial Task 1 start")
        for _ in 0..<10 { _ = 1 + 1 }
        print("Serial Task 1 end")
    }
    serialQueue.sync {
        print("Serial Task 2 start")
        for _ in 0..<10 { _ = 2 + 2 }
        print("Serial Task 2 end")
    }
    serialQueue.sync {
        print("Serial Task 1 start")
        for _ in 0..<10 { _ = 1 + 1 }
        print("Serial Task 1 end")
    }
    serialQueue.async {
         print("Serial Task 2 start")
        for _ in 0..<10 { _ = 2 + 2 }
         print("Serial Task 2 end")
    }
}
// doSerialQueueWork()



// 4.3 Custom Queue — Concurrent (parallel possible)


let concurrentQueue = DispatchQueue(label: "com.example.concurrentQueue", attributes: .concurrent)

func doConcurrentQueueWork() {
    concurrentQueue.async {
        // print("Concurrent Task A start")
        for _ in 0..<10 { _ = 3 + 3 }
        // print("Concurrent Task A end")
    }
    concurrentQueue.sync {
        // print("Concurrent Task B start")
        for _ in 0..<10 { _ = 4 + 4 }
        // print("Concurrent Task B end")
    }
    concurrentQueue.async(flags: .barrier) {
        // print("Barrier Task (A & B finish before this)")
        // Safe write to shared resource could go here
    }
    concurrentQueue.sync {
        // print("Concurrent Task C start (after barrier starts)")
        for _ in 0..<10 { _ = 5 + 5 }
        // print("Concurrent Task C end")
    }
}
// doConcurrentQueueWork()



// 4.4 Global Queues + different QoS priorities


func doGlobalQoSExamples() {
    
    DispatchQueue.global(qos: .userInitiated).async {
        // print("QoS.userInitiated → user-triggered needs result soon")
    }
    DispatchQueue.global(qos: .utility).async {
        // print("QoS.utility → long tasks user knows about (downloads)")
    }
    DispatchQueue.global(qos: .default).async {
        // print("QoS.default → middle ground")
    }
    DispatchQueue.global(qos: .background).async {
        // print("QoS.background → maintenance (sync, cleanup)")
    }
    DispatchQueue.global(qos: .unspecified).async {
        // print("QoS.unspecified → lowest / not specified")
    }
    DispatchQueue.global(qos: .userInteractive).async {
        // print("QoS.userInteractive → animations / instant UI feedback")
    }
}
// doGlobalQoSExamples()



// Tiny Safe Image Load Demo (Global -> Main)
// Visual: worker belt (global) fetches data → VIP lane (main) shows it


//func LoadImage(from Url: URL, Into ImageView: UIImageView) {
//    DispatchQueue.global().async {
//        let Data = try? Data(contentsOf: Url)
//        let Image = Data.flatMap { UIImage(data: $0) }
          
//        DispatchQueue.main.async {
//if image == nil {
//    
//} else {
//            ImageView.image = Image
//             print("Image set on main thread?", Thread.isMainThread) }
//        }
//    }
//}
//// Example usage:
// let DemoView = UIImageView()
////fetch('https://dummyjson.com/image/150')
// if let Url = URL(string: "https://dummyjson.com/image/150") {
//     LoadImage(from: Url, Into: DemoView)
// }
//
//class UIImageView {
//    
//}




