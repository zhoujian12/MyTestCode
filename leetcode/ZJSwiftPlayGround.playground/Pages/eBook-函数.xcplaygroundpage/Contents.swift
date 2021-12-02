//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

extension BinaryInteger {
    var isEven: Bool { return self % 2 == 0 }
    
}

32.isEven
15.isEven

func isEven<T: BinaryInteger>(_ i: T) -> Bool{
    return i % 2 == 0
}

isEven(32)

//变量不能持有泛型函数
let int8isEven: (Int8) -> Bool = isEven
int8isEven(3)


//函数的灵活性
let myArray = [3, 1, 2]
myArray.sorted() // [1, 2, 3]
myArray.sorted(by: >) // [3, 2, 1]

//元祖
var numberStrings = [(2, "two"), (1, "one"), (3, "three")]
numberStrings.sort(by: <)
numberStrings // [(1, "one"), (2, "two"), (3, "three")]

var numberStrings1 = [(2, "two"), (1, "one"), (1, "bee"), (1, "and"), (3, "three")]
numberStrings1.sort(by: <)
numberStrings1 // [(1, "one"), (2, "two"), (3, "three")]

[1,2,3].forEach { element in print(element) }

(1..<10).forEach { number in
 print(number)
// if number > 2 { return }
}

let animals = ["elephant", "zebra", "dog"]

//animals.sorted { lhs, rhs in
//    print("--- lhs:\(lhs) rhs:\(rhs)")
//
//    let l = lhs.reversed()
//    let r = rhs.reversed()
//    print("l: \(l) r:\(r) lhs:\(lhs) rhs:\(rhs)")
//    print("l.lexicographicallyPrecedes(r) : \(l.lexicographicallyPrecedes(r))")
//    return l.lexicographicallyPrecedes(r)
//
//}
// ["zebra", "dog", "elephant"]

@objcMembers
final class Person: NSObject {
    let frst: String
    let last: String
    let yearOfBirth:Int
    init(frst: String, last: String, yearOfBirth: Int) {
        self.frst = frst
        self.last = last
        self.yearOfBirth = yearOfBirth
        // super.init() 在这⾥被隐式调⽤
    }
}

let people = [
    Person(frst: "Emily", last: "Young", yearOfBirth: 2002), Person(frst: "David", last: "Gray", yearOfBirth: 1991), Person(frst: "Robert", last: "Barnes", yearOfBirth: 1985), Person(frst: "Ava", last: "Barnes", yearOfBirth: 2000), Person(frst: "Joanne", last: "Miller", yearOfBirth: 1994), Person(frst: "Ava", last: "Barnes", yearOfBirth: 1998), ]

let lastDescriptor = NSSortDescriptor(key: #keyPath(Person.last), ascending: true,
 selector: #selector(NSString.localizedStandardCompare(_:)))
let frstDescriptor = NSSortDescriptor(key: #keyPath(Person.frst), ascending: true,
 selector: #selector(NSString.localizedStandardCompare(_:)))
let yearDescriptor = NSSortDescriptor(key: #keyPath(Person.yearOfBirth), ascending: true)

let descriptors = [lastDescriptor, frstDescriptor, yearDescriptor]
(people as NSArray).sortedArray(using: descriptors)
/*[Ava Barnes (1998), Ava Barnes (2000), Robert Barnes (1985), David Gray (1991), Joanne Miller (1994), Emily Young (2002)] */

var strings = ["Hello", "hallo", "Hallo", "hello"]
strings.sort { $0.localizedStandardCompare($1) == .orderedAscending}
strings // ["hallo", "Hallo", "hello", "Hello"]

people.sorted { $0.yearOfBirth < $1.yearOfBirth }


func increment(value: inout Int) { value += 1 }
var i = 0
increment(value: &i)

var array = [0, 1, 2]
increment(value: &array[0])
array // [1, 1, 2]

struct Point {
    var x: Int
    var y: Int
}
var point = Point(x: 0, y: 0)
increment(value: &point.x)

postfix func ++(x: inout Int) { x += 1 }
point.x++
point // Point(x: 2, y: 0)

i++
var dictionary = ["one": 1]
dictionary["one"]?++
dictionary["one"] // Optional(2)

func incref(pointer: UnsafeMutablePointer<Int>) -> () -> Int
{ // 将指针的的复制存储在闭包中
 return { pointer.pointee += 1
 return pointer.pointee }
}


let fun: () -> Int
do {
 var array = [0]
 fun = incref(pointer: &array)
}
fun()
