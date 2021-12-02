//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)
//var s: Int = 0
//for i in 0..<19{
//    print("\(i) - \(s)")
//}

//概述
//一个枚举由零个或多个成员 (case) 组成，每个成员都可以有一个元组样式的关联值(associated value) 列表
//就像结构体一样，枚举也是值类型。它的能力几乎和结构体相同
//但枚举不能拥有存储属性。一个枚举的状态完全由它的成员和成员的关联值组合起来表示。对于某个特定的成员，可以将关联值视为其存储属性
enum TextAlignment {
    case left
    case center
    case right }

@_frozen enum Optional<Wrapped> { /// 没有值。
 case none /// 存在⼀个值，保存为 `Wrapped`。
 case some(Wrapped) }

enum Result<Success, Failure: Error> { /// 成功, 保存⼀个 `Success` 值。
 case success(Success)
 /// 失败, 保存⼀个 `Failure` 值。
 case failure(Failure) }

let alignment = TextAlignment.left
//let download: Result<String, NetworkError> = .success("<p>Hello world!</p>")

extension TextAlignment {
    init(defaultFor locale: Locale) {
        guard let language = locale.languageCode else { // 以下是没能获得当前语⾔时的默认值。
            self = .left
            return
        }
        switch Locale.characterDirection(forLanguage: language) {
        case .rightToLeft:
            self = .right // Left 是对于其他情况的默认值。
        case .leftToRight, .topToBottom, .bottomToTop, .unknown:
            self = .left
        @unknown default:
            self = .left
        }
    }
}

let english = Locale(identifier: "en_AU")
TextAlignment(defaultFor: english) //left
let arabic = Locale(identifier: "ar_EG")
TextAlignment(defaultFor: arabic) // right

//总和类型和乘积类型
//现在考虑一个有两个布尔字段的元组：(Bool, Bool
//一个元组 (或者结构体，类) 的居民数量，等于其成员的居民数量的乘积。因此，结构体，类和元组也被称为乘积类型 (Product Types)。
enum PrimaryColor {
    case red
    case yellow
    case blue }


//模式匹配
//enum Shape {
//    case line(from: Point, to: Point)
// case rectangle(origin: Point, width: Double, height: Double)
// case circle(center: Point, radius: Double) }
    
    let randomNumber = Int8.random(in: .min...(.max))
    
    switch randomNumber {
    case ..<0:
        print("\(randomNumber) is negative")
    case 0:
        print("\(randomNumber) is zero")
    case 1...:
        print("\(randomNumber) is positive")
    default:
        fatalError("Can never happen")
    }

//func ~=(pattern: ???, value: ???) -> Bool

//在其他上下文中的模式匹配
///在赋值时解构元组
for n in 1...10 where n.isMultiple(of: 3) { print(n) }

//字典是无序的
["a":"b","c":4].map { (key, value) in
    print("key:\(key) value:\(value)")
}


//使用枚举进行设计

//Switch 语句的完备性
///一个 switch 语句必须是完备的，也就是说，它的分支必须覆盖所有可能的输入值。编译器也会强制执行这个完备性
let point = (1, 2)
switch point {
case (0, 0):
    print("(0, 0) is at the origin.")
case (-2...2, -2...2):
    print("(\(point.0), \(point.1)) is near the origin.")
default:
    print("The point is at (\(point.0), \(point.1)).")
}

func ~= (pattern: String, value: Int) -> Bool {
    return pattern == "\(value)"
}
switch point {
case ("0", "0"):
    print("(0, 0) is at the origin.")
default:
    print("The point is at (\(point.0), \(point.1)).")
}

enum testG: Int{
    case a ;
    case b
}

//使用枚举实现递归数据结构
/// ⼀个单向链表。
enum List<Element> {
    case end
    indirect case node(Element, next: List<Element>)
}

extension List { /// 把⼀个含有值 `x` 的节点添加到链表的头部。 /// 然后返回整个链表。
 func cons(_ x: Element) -> List {
     return .node(x, next: self)
 }
    
    mutating func push(_ x: Element) {
        self = self.cons(x)
     }
    
    mutating func pop() -> Element? {
        switch self {
        case .end:
            return nil
        case let .node(x, next: tail):
            self = tail
            return x
     }
    }
}

extension List: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        self = elements.reversed().reduce(.end) { partialList, element in
            partialList.cons(element)
        }
    }
}

// ⼀个含有 (3 2 1) 三个元素的链表。
let list = List<Int>.end.cons(1).cons(2).cons(3)
print(list)

let list2: List = [3,2,1]
print(list2)

var stack: List<Int> = [3, 2, 1]
var a = stack
var b = stack
a.pop() // Optional(3)
stack.pop() // Optional(3)
stack.push(4)
b.pop() // Optional(3)
b.pop() // Optional(2)
stack.pop() // Optional(4)
stack.pop() // Optional(2)

//原始值 (Raw Value)

enum HTTPStatus: Int {
    case hh
    case ok = 200
    case created = 201 // ...
    case hhh
    case movedPermanently = 301 // ...
    case notFound = 404 // ...
}

print(HTTPStatus.hh)
print(HTTPStatus.hh.rawValue) //默认为0
print(HTTPStatus.ok)
print(HTTPStatus.ok.rawValue)
print(HTTPStatus.hhh.rawValue)

/// ⼀个可以同相关原始值做转换的类型。
protocol RawRepresentable { /// 原始值的类型, 例如 Int 或 String。
    associatedtype RawValue
    init?(rawValue: RawValue)
    
    var rawValue: RawValue { get }
    
}

HTTPStatus(rawValue: 404) // Optional(HTTPStatus.notFound)
HTTPStatus(rawValue: 1000) // nil
HTTPStatus.created.rawValue // 201


enum MenuItem: String, CaseIterable {
    case undo = "Undo"
    case cut = "Cut"
    case copy = "Copy"
    case paste = "Paste" }

MemoryLayout<MenuItem>.size // 1
MenuItem.allCases // [MenuItem.undo, MenuItem.cut, MenuItem.copy, MenuItem.paste]
MenuItem.allCases.count // 4
print(MenuItem.allCases.map { $0.rawValue }) // ["Undo", "Cut", "Copy", "Paste"]

extension Bool: CaseIterable {
    public static var allCases: [Bool] {
        return [false, true]
         }
}
        Bool.allCases // [false, true]

extension UInt8: CaseIterable {
    public static var allCases: ClosedRange<UInt8> {
        return .min ... .max
    }
}
UInt8.allCases.count // 256
UInt8.allCases.prefix(3) + UInt8.allCases.suffix(3) // [0, 1, 2, 253, 254, 255]


let isImportant: Bool = false
let isUrgent: Bool = false
let priority: Int

switch isImportant {
case true:
 switch isUrgent {
 case true: priority = 3
 case false: priority = 2
 }
case false:
 switch isUrgent {
 case true: priority = 1
 case false: priority = 0
 } }
print("priority: \(priority)")

let priority2: Int
switch (isImportant, isUrgent) {
case (true, true): priority2 = 3
case (true, false): priority2 = 2
case (false, true): priority2 = 1
case (false, false): priority2 = 0
}

print("priority2: \(priority2)")


//避免用 none 或 some 来命名成员。
enum Selection {
    case none
    case some
    case all
}

var optionalSelection: Selection?
print(".some : \(Selection.some)")

//这里是匹配了 Selection.some 还是匹配了 Optional.some (即任何非 nil 的值) ？答案是后者，但这很容易出错，特别是考虑到 Swift 喜欢隐式地将非可选值提升为可选值。
if case .some = optionalSelection { // 哪个 some 被匹配到了？
    print("hhh")
}

//对那些用保留的关键字来命名的成员使用反引号 (backtick)。
enum Strategy {
    case custom
    case `default` // 需要反引号。
    
}

let strategy = Strategy.default

enum OpaqueColor {
    case rgb(red: Float, green: Float, blue: Float)
    case gray(intensity: Float)
}

let gradient = stride(from: 0.0, through: 1.0, by: 0.25).map(OpaqueColor.gray)
print(gradient)

//不要使用关联值来模拟存储属性。请改用结构体
enum AlphaColor {
    case rgba(red: Float, green: Float, blue: Float, alpha: Float)
    case gray(intensity: Float, alpha: Float) }

struct Color {
    var color: OpaqueColor
    var alpha: Float }

//不要过度使用关联值组件
//struct Line {
//    var from: Point
//    var to: Point }

//把空枚举作为命名空间
/// ⼀个含有 Unicode 实⽤⽅法的命名空间。
public enum Unicode {
    public struct Scalar {
        internal var _value: UInt32 // ...
        
    } // ...
    
}

enum aTest: Int {
case null = -1,
 a , b , c
}

aTest.null
print(aTest.a)
print(aTest.a.rawValue)
print(aTest.b)
print(aTest.b.rawValue)
print(aTest.c)
print(aTest.c.rawValue)
