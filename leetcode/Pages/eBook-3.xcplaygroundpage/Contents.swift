//: [Previous](@previous)

import Foundation

//var greeting = "Hello, playground"
//
////: [Next](@next)
//
//struct Point {
//    var x: Double
//    var y: Double
//    private(set) lazy var distanceFromOrigin: Double = (x*x + y*y).squareRoot()
//    init(x: Double, y: Double) {
//        self.x = x
//        self.y = y
//    }
//}
//
//var point = Point(x: 3, y: 4)
//point.distanceFromOrigin // 5.0
//point.x += 10
//point.distanceFromOrigin // 5.0
//
////let immutablePoint = Point(x: 3, y: 4)
////immutablePoint.distanceFromOrigin
//
////下标
//let fbs = [0, 1, 1, 2, 3, 5]
//let frst = fbs[0] // 0
//fbs[1..<3] // [1, 1]
//
//
//extension Collection {
//    subscript(indices indexList: Index...) -> [Element]
//    {
//        var result: [Element] = []
//        for index in indexList
//        { result.append(self[index]) }
//        return result
//
//    }
//}
//Array("abcdefghijklmnopqrstuvwxyz")[indices: 7, 4, 11, 11, 14]
//
//var japan: [String: Any] = [ "name": "Japan",
// "capital": "Tokyo",
// "population": 126_740_000,
// "coordinates": [ "latitude": 35.0,
// "longitude": 139.0 ] ]
//
////japan["coordinate"]?["latitude"] = 36.0
////(japan["coordinates"] as? [String: Double])?["coordinate"] = 36.0
//
//extension Dictionary {
//    subscript<Result>(key: Key, as type: Result.Type) -> Result?{
//        get {
//            return self[key] as? Result
//        }
//        set { // 如果传⼊ nil, 就删除现存的值。
//            guard let value = newValue else {
//                self[key] = nil
//                return
//
//            }
//            // 如果类型不匹配，就忽略掉。
//            guard let value2 = value as? Value else {
//                return }
//            self[key] = value2
//        }
//    }
//}
////(japan["coordinates"] as? [String: Double])?["coordinate"] = 36.0
//
//japan["coordinates", as: [String: Double].self]?["latitude"] = 36.0
//japan["coordinates"]
//
//struct Address {
//    var street: String
//    var city: String
//    var zipCode: Int
//}
//
//struct Person {
//    let name: String
//    var address: Address
//}
//
//let streetKeyPath = \Person.address.street // Swift.WritableKeyPath<Person, Swift.String>
//let nameKeyPath = \Person.name // Swift.KeyPath<Person, Swift.String>
////let nameKeyPath1 = \.name
//
//"Hello"[keyPath: \.count]
//"Hello".count
//
//let simpsonResidence = Address(street: "1094 Evergreen Terrace", city: "Springfeld", zipCode: 97475)
//var lisa = Person(name: "Lisa Simpson", address: simpsonResidence)
//lisa[keyPath: nameKeyPath] // Lisa Simpson
//lisa[keyPath: streetKeyPath] = "742 Evergreen Terrace"
//print(lisa)
//var bart = Person(name: "Bart Simpson", address: simpsonResidence)
//let people = [lisa, bart]
//people[keyPath: \.[1].name] // Bart Simpson
//
//
//let nameCountKeyPath = nameKeyPath.appending(path: \.count)
//// Swift.KeyPath<Person, Swift.Int>
//
//typealias SortDescriptor<Root> = (Root, Root) -> Bool
//
//func sortDescriptor<Root, Value>(key: @escaping (Root) -> Value)
//-> SortDescriptor<Root> where Value: Comparable {
//    return { key($0) < key($1) }
//}
//
//let streetSD: SortDescriptor<Person> = sortDescriptor { $0.address.street }
//
//func sortDescriptor<Root, Value>(key: KeyPath<Root, Value>) -> SortDescriptor<Root> where Value: Comparable {
//    return { $0[keyPath: key] < $1[keyPath: key] }
//
//}
//
//let streetSDKeyPath: SortDescriptor<Person> = sortDescriptor(key: \.address.street)
//
////可写键路径
////let streetKeyPath = \Person.address.street
//let getStreet: (Person) -> String = { person in return person.address.street }
//let setStreet: (inout Person, String) -> () = { person, newValue in person.address.street = newValue }
//// 使⽤ Setter
//lisa[keyPath: streetKeyPath] = "1234 Evergreen Terrace"
//print(lisa)
//setStreet(&lisa, "1234 Evergreen Terrace1")
//print(lisa)
//
//extension NSObjectProtocol where Self: NSObject {
//    func observe<A, Other>(_ keyPath: KeyPath<Self, A>, writeTo other: Other,
//                           _ otherKeyPath: ReferenceWritableKeyPath<Other, A>) -> NSKeyValueObservation where A: Equatable, Other: NSObjectProtocol {
//        return observe(keyPath, options: .new) { _, change in
//            guard let newValue = change.newValue,
//                  other[keyPath: otherKeyPath] != newValue else {
//                      return // prevent endless feedback loop
//                  }
//            other[keyPath: otherKeyPath] = newValue
//        }
//    }
//
//    func bind<A, Other>(_ keyPath: ReferenceWritableKeyPath<Self,A>, to other: Other,
//     _ otherKeyPath: ReferenceWritableKeyPath<Other,A>) -> (NSKeyValueObservation, NSKeyValueObservation)
//    where A: Equatable, Other: NSObject {
//        let one = observe(keyPath, writeTo: other, otherKeyPath)
//        let two = other.observe(otherKeyPath, writeTo: self, keyPath)
//        return (one,two)
//    }
//}
//final class Person: NSObject { @objc dynamic var name: String = "" }
//final class TextField: NSObject { @objc dynamic var text: String = "" }
//
//let person = Person()
//let textField = TextField()
//let observation = person.bind(\.name, to: textField, \.text)
//person.name = "John"
//textField.text // John textField.text = "Sarah" person.name // Sarah
//textField.text = "haha"
//person.name
//
////闭包
//let evens = [2,4,6]
//if !evens.isEmpty && evens[0] > 1 {
//    // 执⾏操作
//    print("true")
//}
//
//if let first = evens.first, first > 1 { // 执⾏操作
//    print("true1")
//}
//
//func and(_ l: Bool, _ r: () -> Bool) -> Bool {
//    guard l else { return false }
//    return r()
//
//}
//
//if and(!evens.isEmpty, { evens[0] > 1 }) {
//    // 执⾏操作
//    print("true2")
//}
//
//func log(ifFalse condition: Bool,
//         message: @autoclosure () -> (String), file: String = #file, function: String = #function, line: Int = #line) {
//    guard !condition else { return }
//    print("Assertion failed: \(message()), \(file):\(function) (line \(line))")
//}
//
////@escaping 标注
//func transform(_ input: Int, with f: ((Int) -> Int)?) -> Int { print("使⽤可选值重载")
//    guard let f = f else { return input }
//    return f(input)
//}
//
//func transform(_ input: Int, with f: (Int) -> Int) -> Int { print("使⽤⾮可选值重载")
//    return f(input)
//}
//
//transform(10, with: nil) // 使⽤可选值重载
//transform(10) { $0 * $0 } // 使⽤⾮可选值重载

extension Array {
//    func allSatisfy2(_ predicate: (Element) -> Bool) -> Bool { // 错误: 使⽤⾮逃逸参数 'predicate' 的闭包有可能允许它逃逸。
//    return self.lazy.filter({!predicate($0)}).isEmpty
//}
    
    func allSatisfy3(_ predicate: (Element) -> Bool) -> Bool { return withoutActuallyEscaping(predicate) { escapablePredicate in
        self.lazy.filter{!escapablePredicate($0)}.isEmpty
        
    }
    }
}

//let areAllEven = [1,2,3,4].allSatisfy2 { $0 % 2 == 0 } // false
//let areAllOneDigit = [1,2,3,4].allSatisfy2 { $0 < 10 } // true
let areAllEven1 = [1,2,3,4].allSatisfy3 { $0 % 2 == 0 } // false
let areAllOneDigit1 = [1,2,3,4].allSatisfy3 { $0 < 10 } // true
print("areAllEven1: \(areAllEven1) areAllOneDigit1 : \(areAllOneDigit1) ")
