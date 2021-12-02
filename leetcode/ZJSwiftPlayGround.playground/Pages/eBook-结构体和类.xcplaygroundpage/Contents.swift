//: [Previous](@previous)

import Foundation
import Darwin

var greeting = "Hello, playground"

//: [Next](@next)

var a: Int = 3
var b = a
b += 1
a
b

class ScoreClass {
    var home: Int
    var guest: Int
    init(home: Int, guest: Int) {
        self.home = home
        self.guest = guest }
}

struct ScoreStruct {
    var home: Int
    var guest: Int
    // 编译器会⽣成成员初始化⽅法 (Memberwise initializer)。
}
var score3 = ScoreStruct(home: 0, guest: 0)
var score4 = score3
score4.guest += 1
score3.guest // 0
score4.guest

extension ScoreStruct {
    mutating func scoreGuest() {
        self.guest += 1
 } }
var scoreStruct2 = ScoreStruct(home: 0, guest: 0)
scoreStruct2.scoreGuest()
scoreStruct2.guest // 1


var scoreClass = ScoreClass(home: 0, guest: 0)
var scoreStruct = ScoreStruct(home: 0, guest: 0)

class Window {
    weak var rootView: View?
     deinit {
         print("Deinit Window")
     }
}

class View {
    var window: Window
    init(window: Window) { self.window = window }
    
    deinit { print("Deinit View")
 }
}

var window: Window? = Window()
var view: View? = View(window: window!)
window?.rootView = view
window = nil
view = nil

struct ScoreStruct1 {
    var home: Int
    var guest: Int
    let scoreFormatter: NumberFormatter
    init(home: Int, guest: Int) {
        self.home = home
        self.guest = guest
        scoreFormatter = NumberFormatter()
        scoreFormatter.minimumIntegerDigits = 2
    }
    var pretty: String {
        let h = scoreFormatter.string(from: home as NSNumber)!
        let g = scoreFormatter.string(from: guest as NSNumber)!
        return "\(h) – \(g)"
    }
}
    
let score1 = ScoreStruct1(home: 2, guest: 1)
score1.pretty // 02 – 01

let score2 = score1
score2.scoreFormatter.minimumIntegerDigits = 3
score1.pretty

let queue1 =  DispatchQueue(label: "concurrent.queue1",attributes: .concurrent)
let queue2 =  DispatchQueue(label: "concurrent.queue2",attributes: .concurrent)

var numbers = [1, 2, 3]
queue1.async {
    sleep(1)
    numbers.append(4)
}
queue2.async {
    numbers.append(5)
}
numbers

//swift gcd

struct HTTPRequest {
    fileprivate class Storage {
        var path: String
        var headers: [String: String]
        init(path: String, headers: [String: String]) {
            self.path = path
            self.headers = headers
        }
    }
    private var storage: Storage
    init(path: String, headers: [String: String]) {
        storage = Storage(path: path, headers: headers)
    }
}

extension HTTPRequest.Storage {
    func copy() -> HTTPRequest.Storage { print("Making a copy...") // 调试语句
    return HTTPRequest.Storage(path: path, headers: headers)
 }
}

//extension HTTPRequest {
//    var path: String {
//        get { return storage.path }
//        set {
//            storage = storage.copy()
//            storage.path = newValue
//        }
//    }
//    var headers: [String: String] {
//        get { return storage.headers }
//        set {
//            storage = storage.copy()
//            storage.headers = newValue
//        }
//    }
//}

extension HTTPRequest {
    private var storageForWriting: HTTPRequest.Storage {
        mutating get {
            if !isKnownUniquelyReferenced(&storage) {
                self.storage = storage.copy()
            }
            return storage
        }
    }
    var path: String {
        get { return storage.path }
        set { storageForWriting.path = newValue }
    }
    var headers: [String: String] {
        get { return storage.headers }
        set { storageForWriting.headers = newValue
        }
    }
}

let req1 = HTTPRequest(path: "/home", headers: [:])
var req2 = req1
req2.path = "/users"
req1.path
assert(req1.path == "/home") // 通过

print("----")
var req = HTTPRequest(path: "/home", headers: [:])
for x in 0..<5 { req.headers["X-RequestId"] = "\(x)" }

print("----")
var req3 = HTTPRequest(path: "/home", headers: [:])
var copy = req3
for x in 0..<5 { req3.headers["X-RequestId"] = "\(x)" }
