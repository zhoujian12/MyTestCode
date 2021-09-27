//: [Previous](@previous)

import Foundation

var str1 = "Hello, playground"

//: [Next](@next)

//max(2,1)

let str = "123456789"
let start = str.startIndex//表示str的开始位置
let end = str.endIndex//表示str的结束位置
let startOffset = str.index(start, offsetBy: 2)//表示str的开始位置 + 2
let endOffset = str.index(end, offsetBy: -2)//表示str的结束位置 - 2
        
print(str[start])//输出 1 第1个字符
print(str[startOffset])//输出 3 第3个字符
print(str[endOffset])//输出 8 第8个字符（10-2）
print("\(end)")
//print(str[end])//报错！因为实endIndex指向第10个字符，而第10个字符是不存在的
