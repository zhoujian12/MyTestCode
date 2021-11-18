//: [Previous](@previous)

import Foundation
import UIKit

var greeting = "Hello, playground"

//: [Next](@next)

var b = [String]() + ["c"]
b += ["b"]


var x = 2 ^ 2
var y = 2 ^ 2 ^ 1
var z = 5 ^ 5 ^ 1
var x1 = (1 * 3 * 4) ^ 3


//为什么Swift内置的Dictionary类型的键值对必须遵守Hashable协议
//https://www.jianshu.com/p/a4a2a523d215
var a1 = "firstName".hashValue
var a2 = "hobbies".hashValue


///https://www.jianshu.com/p/4bfbb0ba4d32
var num: Int?

num = 10

if num is Optional<Int> {
 print("它是可选类型")
}else {
 print("它是Int类型")
}

var num1: Int

num1 = 10
if num1 is Optional<Int> {
 print("它是可选类型")
}else {
 print("它是Int类型")
}



class Solution{
    
    func test(_ a: Int, _ b: Int) {
        
        
    }
    
}



//Swift Range和字符串截取 ： https://www.jianshu.com/p/3833a09b1538
let str = "123456789"
let start = str.startIndex//表示str的开始位置
let end = str.endIndex//表示str的结束位置
let startOffset = str.index(start, offsetBy: 2)//表示str的开始位置 + 2
let endOffset = str.index(end, offsetBy: -2)//表示str的结束位置 - 2
        
print(str[start])//输出 1 第1个字符
print(str[startOffset])//输出 3 第3个字符
print(str[endOffset])//输出 8 第8个字符（10-2）
//print(str[end])//报错！因为实endIndex指向第10个字符，而第10个字符是不存在的


//extension
    /// 根据下标获取某个下标字符
extension String{
    subscript(of index: Int) -> String {
        if index < 0 || index >= self.count{
            return ""
        }
        for (i,item) in self.enumerated(){
            if index == i {
                return "\(item)"
            }
        }
        return ""
    }
    /// 根据range获取字符串 a[1...3]
    subscript(r: ClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(r.lowerBound, 0))
        let end = index(startIndex, offsetBy: min(r.upperBound, count - 1))
        return String(self[start...end])
    }
    /// 根据range获取字符串 a[0..<2]
    subscript(r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: max(r.lowerBound, 0))
        let end = index(startIndex, offsetBy: min(r.upperBound, count))
        return String(self[start..<end])
    }
    /// 根据range获取字符串 a[...2]
    subscript(r: PartialRangeThrough<Int>) -> String {
        let end = index(startIndex, offsetBy: min(r.upperBound, count - 1))
        return String(self[startIndex...end])
    }
    /// 根据range获取字符串 a[0...]
    subscript(r: PartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(r.lowerBound, 0))
        let end = index(startIndex, offsetBy: count - 1)
        return String(self[start...end])
    }
    /// 根据range获取字符串 a[..<3]
    subscript(r: PartialRangeUpTo<Int>) -> String {
        let end = index(startIndex, offsetBy: min(r.upperBound, count))
        return String(self[startIndex..<end])
    }
    /// 截取字符串: index 开始到结尾
    /// - Parameter index: 开始截取的index
    /// - Returns: string
    func subString(_ index: Int) -> String {
        guard index < count else {
            return ""
        }
        let start = self.index(endIndex, offsetBy: index - count)
        return String(self[start..<endIndex])
    }
    
    /// 截取字符串
    /// - Parameters:
    ///   - begin: 开始截取的索引
    ///   - count: 需要截取的个数
    /// - Returns: 字符串
    func substring(start: Int, _ count: Int) -> String {
        let begin = index(startIndex, offsetBy: max(0, start))
        let end = index(startIndex, offsetBy: min(count, start + count))
        return String(self[begin..<end])
    }
}

str[of:4]
str[1...3]
str[1..<3]
str[...3]
str[1...]
str[..<3]

func testAsyncToSync() -> Bool  {
    let semaphore = DispatchSemaphore(value: 0)
    var canOpen = false
    let url = URL.init(string: "www.baidu.com")
    let suc: Void = UIApplication.shared.open(url!, options: [:])
    print("suc :\(suc)")
    UIApplication.shared.open(url!, options: [:]) { success in
        canOpen = success
        print("success :\(success)")
        semaphore.signal()
    }
    semaphore.wait()
    return canOpen
}


testAsyncToSync()
