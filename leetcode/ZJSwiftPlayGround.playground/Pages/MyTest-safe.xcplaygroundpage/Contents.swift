//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)


//public extension Collection {
//    subscript(safe index: Index) -> Element? {
//        return indices.contains(index) ? self[index] : nil
//    }
//}
//
//let list = [1, 2, 3, 4]
//let index = 5
//
//let safeIndexValue = list[safe: 5] // nil, index超过数组下标，安全返回nil
//let value1 = list[1] // 2

public extension Array {

    ///数组越界防护
    subscript(safe idx: Index) -> Element? {
        if idx < 0 { return nil }
        return idx < self.endIndex ? self[idx] : nil
    }
}

enum HistoryType {
    case empty
    case university
    case k12
}

var arr: [HistoryType] = []
arr.append(.k12)
arr.insert(.university, at: 0)
arr.removeFirst()
arr.removeFirst()
let s = arr[safe:0]
print("s:\(String(describing: s)) count:\(arr.count) arr:\(arr)")


//print("count: \(arr.count)")
//arr.removeFirst()
//arr.remove(at: 1)

let fbs = [0, 1, 1, 2, 3, 5]
let ss = fbs.reduce("") { str, num in str + "\(num), " }
print("ss : \(ss)")

let slice = fbs[2...] //slice // [1, 1, 2, 3, 5]
print("slice : \(slice)")
print("slice.startIndex : \(slice.startIndex)")
type(of: slice) // ArraySlice<Int>

let newArray = Array(slice)
type(of: newArray) // Array<Int>


//MARK: Dictionary
enum Setting {
 case text(String)
 case int(Int)
 case bool(Bool)
}
let defaultSettings: [String:Setting] = [ "Airplane Mode": .bool(false), "Name": .text("My iPhone"), ]
defaultSettings["Name"] // Optional(Setting.text("My iPhone"))
print("defaultSettings[Name] : \(String(describing: defaultSettings["Name"]))")

var userSettings = defaultSettings
userSettings["Name"] = .text("Jared's iPhone")
userSettings["Do Not Disturb"] = .bool(true)


let oldName = userSettings .updateValue(.text("Jane's iPhone"), forKey: "Name")
userSettings["Name"] // Optional(Setting.text("Jane\'s iPhone"))
oldName // Optional(Setting.text("Jared\'s iPhone"))

var settings = defaultSettings
var overriddenSettings: [String:Setting] = ["Name": .text("Jane's iPhone")]
overriddenSettings.merge(settings, uniquingKeysWith: { $1 })
settings


extension Sequence where Element: Hashable { var frequencies: [Element:Int] {
    let frequencyPairs = self.map { ($0, 1) }
    return Dictionary(frequencyPairs, uniquingKeysWith: +)
    
  }
}
let frequencies = "hello".frequencies // ["o": 1, "h": 1, "e": 1, "l": 2]
frequencies.filter { $0.value > 0 } // ["l": 2]


let settingsAsStrings = settings.mapValues { setting -> String in switch setting {
case .text(let text): return text
case .int(let number): return String(number)
case .bool(let value): return String(value)
 }
    
}
settingsAsStrings // ["Name": "Jane\'s iPhone", "Airplane Mode": "false"]

//MARK: Set
var indices = IndexSet()
indices.insert(integersIn: 1..<5)
indices.insert(integersIn: 11..<15)
let evenIndices = indices.filter { $0 % 2 == 0 }
print("evenIndices: \(evenIndices) indices: \(indices)")

extension Sequence where Element: Hashable {
    func unique() -> [Element]  {
        var seen: Set<Element> = []
        return filter { element in
            if seen.contains(element) {
                return false }
            else {
                seen.insert(element)
                return true
                
            }
            
        }
        
    }
    
}
[1,2,3,12,1,3,4,5,6,4,6].unique() // [1, 2, 3, 12, 4, 5, 6]


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

