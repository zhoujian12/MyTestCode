//: [Previous](@previous)

import Foundation
import UIKit
import Darwin

var greeting = "Hello, playground"

//: [Next](@next)

//MARK: Range
// 0 到 9, 不包含 10
let singleDigitNumbers = 0..<10
Array(singleDigitNumbers) // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
// 包含 "z"
let lowercaseLetters = Character("a")...Character("z")


let fromZero = 0...
let upToZ = ..<Character("z")

singleDigitNumbers.contains(9) // true
lowercaseLetters.overlaps("c"..<"f") // true

for i in 0..<10 { print("\(i)", terminator: " ")
} // 0 1 2 3 4 5 6 7 8 9
singleDigitNumbers.last // Optional(9)


//public protocol RangeExpression {
//    associatedtype Bound: Comparable
//    func contains(_ element: Bound) -> Bool
//    func relative<C>(to collection: C) -> Range<Bound> where C: Collection, Self.Bound == C.Index
//
//}

let arr = [1,2,3,4]
arr[2...] // [3, 4]
arr[..<1] // [1]
arr[1...2] // [2, 3]

arr[...] // [1, 2, 3, 4]
type(of: arr) // Array<Int>


//optional
enum Optional<Wrapped> {
    case none
    case some(Wrapped)
}

let stringNumbers = ["1", "2", "three"]
let maybeInts = stringNumbers.map { Int($0) }


for maybeInt in maybeInts {
    // maybeInt 是⼀个 Int? 值
 // 得到两个整数值和⼀个 `nil`
    print("maybeInt : \(maybeInt)")
    
}

var iterator = maybeInts.makeIterator()
while let maybeInt = iterator.next() {
    print(maybeInt, terminator: " --")
}
// Optional(1) Optional(2) nil

for case let i? in maybeInts {
    // i 将是 Int 值，⽽不是 Int?
    print(i, terminator: " \n")
}
// 1 2

for case nil in maybeInts { // 将对每个 nil 执⾏⼀次
 print("-- No value")
}
// No value


for case let.some(i) in maybeInts{
    print(i)
}

var b:Int? = nil
b? = 10
b//nil


let characters:[[Character:Int]]=[["a":1],["b":2],["c":3]]
//String(characters[0])//a

var frstCharAsString: String? = nil
//if let char = characters.first { frstCharAsString = String(char) }
//let frstChar = characters.first.map { String($0) } // Optional("a")
//let frstChar = characters.first.map { String($1) } // Optional("a")
//let frstChar = characters.first.map { String($2) } // Optional("a")

var dic = ["a":1,"b":2]
dic.map { (key: String, value: Int) in
    print("key: \(key)  value: \(value)")

}

extension Array { func reduce(_ nextPartialResult: (Element, Element) -> Element) -> Element? { // 如果数组为空，frst 将是 nil
    guard let fst = first else { return nil }
    return dropFirst().reduce(fst, nextPartialResult)
 }
}

[1, 2, 3, 4].reduce(+) // Optional(10)
var t:Int = 3
//t = nil
//t? = "3"
[1, 2, t, 4].reduce(+) // Optional(10)
extension String{
func subStringTo(_ index: Int) -> String {
        let temporaryString = self
        let temporaryIndex = temporaryString.index(temporaryString.startIndex, offsetBy: index)
        return String(temporaryString[..<temporaryIndex])
}
}

let hh = "liushourun".subStringTo(7)

//链接：https://juejin.cn/post/6844903792647864328

struct Point {
    let x: Double
    let y: Double
//    修饰存储属性
    static let zero = Point(x: 0, y: 0)
//    修饰计算属性
    static var ones: [Point] {
        return [Point(x: 1, y: 2)]
    }
//    修饰类型方法
    static func add(p1: Point, p2: Point) -> Point {
        return Point(x: p1.x + p2.x, y: p1.y + p2.y)
    }
    
    static func overadd(p1: Point, p2: Point) -> Point {
        return Point(x: p1.x + p2.x, y: p1.y + p2.y)
    }
}

class Point1 {
    let x: Double
    let y: Double
    
    init(x:Double, y:Double ) {
        self.x = x
        self.y = y
    }
//    修饰存储属性
    static let zero = Point1(x: 0, y: 0)
//    修饰计算属性
    static var ones: [Point1] {
        return [Point1(x: 1, y: 2)]
    }
//    修饰类型方法
    static func add(p1: Point1, p2: Point1) -> Point1 {
        return Point1(x: p1.x + p2.x, y: p1.y + p2.y)
    }
    
    class func overadd(p1: Point1, p2: Point1) -> Point1 {
        return Point1(x: p1.x + p2.x, y: p1.y + p2.y)
    }
}

if let first = Point.ones.first{
  print(Point.add(p1: .zero, p2: first))
  print(Point.overadd(p1: .zero, p2: first))
}

if let first = Point1.ones.first{
    let p1 = Point1.add(p1: .zero, p2: first)
    print("p1: \(p1.x) \(p1.y)")
    let p2 = Point1.overadd(p1: .zero, p2: first)
    print("p2: \(p2.x) \(p2.y)")

  print(Point1.overadd(p1: .zero, p2: first))
}

//可选值 flatMap
let stringNumbers1 = ["1", "2", "3", "foo"]
let x = stringNumbers1.first.map { Int($0) } // Optional(Optional(1))

let urlString = "https://www.objc.io/logo.png"
let view = URL(string: urlString)
 .flatMap { try? Data(contentsOf: $0) }
 .flatMap { UIImage(data: $0) }
 .map { UIImageView(image: $0) }
//if let view = view {
//    PlaygroundPage.current.liveView = view
//}

let numbers = ["1", "2", "3", "foo"]
//var sum = 0
//for case let i? in numbers.map({ Int($0) }) {
//    sum += i
//    print("i : \(i) sum:\(sum)")
//}

infix operator !!
func !! <T>(wrapped: T?, failureText: @autoclosure () -> String) -> T
{ if let x = wrapped {
    return x
    
}
    fatalError(failureText())
}

let s = "foo"
//let i = Int(s) !! "Expecting integer, got \"\(s)\""

//{
//    print("s : \(s)")
    print("s :")
//}

//func
func printInt(i: Int) {
    print("You passed \(i).")
}

let funVar = printInt
printInt(i:2)
funVar(3)
//funVar(i:4)


func useFunction(function: (Int) -> () ) {
    function(4)
}
useFunction(function: printInt) // You passed 3.
useFunction(function: funVar) // You passed 3.


func returnFunc() -> (Int) -> String {
    func innerFunc(i: Int) -> String { return "you passed \(i)" }
    return innerFunc
}

let myFunc = returnFunc()
myFunc(3) // you passed 3


func counterFunc() -> (Int) -> String {
    var counter = 0
    func innerFunc(i: Int) -> String { counter += i // counter 被捕获
        return "Running total: \(counter)"
    }
    return innerFunc
    
}

let f = counterFunc()
f(3) // Running total: 3
f(4) // Running total: 7

func doubler(i: Int) -> Int { return i * 2 }
[1, 2, 3, 4].map(doubler) // [2, 4, 6, 8]

let doublerAlt = { (i: Int) -> Int in return i*2 }
[1, 2, 3, 4].map(doublerAlt) // [2, 4, 6, 8]

let m = [1, 2, 3].map { $0 * 2 } // [2, 4, 6]
print(m)

[1, 2, 3].map( { (i: Int) -> Int in return i * 2 } )
[1, 2, 3].map( { i in return i * 2 } )
[1, 2, 3].map( { i in i * 2 } )
[1, 2, 3].map( { $0 * 2 } )
[1, 2, 3].map() { $0 * 2 }
[1, 2, 3].map { $0 * 2 }

(0..<3).map { _ in Int.random(in: 1..<100) } // [53, 63, 88]

let isEven = { $0 % 2 == 0 }
let isEvenAlt = { (i: Int8) -> Bool in i % 2 == 0 }
let isEvenAlt2: (Int8) -> Bool = { $0 % 2 == 0 }
let isEvenAlt3 = { $0 % 2 == 0 } as (Int8) -> Bool
isEven(4)
isEvenAlt3(3)


///swift 获取数组中某个元素的下标
