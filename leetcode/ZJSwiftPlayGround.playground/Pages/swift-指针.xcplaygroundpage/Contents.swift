//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)
//https://www.jianshu.com/p/e72a6f7a8497
//https://onevcat.com/2015/01/swift-pointer/

var age = 18
let p = withUnsafePointer(to: &age) { ptr in
    return ptr }
print(p)
print(p.pointee)

age = withUnsafePointer(to: &age) { ptr in
    //返回Int整型值
    return ptr.pointee + 12
}
print(age)

age = 18
//分配容量大小，为8字节
let ptr = UnsafeMutablePointer<Int>.allocate(capacity: 1)
//初始化
ptr.initialize(to: age)
ptr.deinitialize(count: 1)

ptr.pointee += 12
print("ptr.pointee: \(ptr.pointee)")

//释放
ptr.deallocate()

//分配容量大小，为8字节
let ptrStr = UnsafeMutablePointer<String>.allocate(capacity: 1)
//初始化
ptrStr.initialize(to: "haha")
ptrStr.deinitialize(count: 1)

ptrStr.pointee += "hehe"
print("ptrStr.pointee: \(ptrStr.pointee)")

//释放
ptrStr.deallocate()

func incrementor(ptr: UnsafeMutablePointer<Int>) {
    ptr.pointee += 1
}

var a = 10
incrementor(ptr: &a)
print(a)


var w :NSObject? = nil
print("\(w) w?.superclass: \(w?.hash)")

w = NSObject()
print(w!.hash)
print(w?.hash)
print("\(w) \(w!)  w?.superclass: \(w!.hash)")


let str1 = ""
let str2 = " "
let str3 = "a"
str1.isEmpty
str2.isEmpty
str3.isEmpty
str1.count > 0
str2.count > 0
str3.count > 0
