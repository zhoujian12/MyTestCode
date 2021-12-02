//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

//所有的现代编程语言都支持 Unicode 字符串，但是通常这只意味着原生的字符串类型可以存储Unicode 数据 - 它没有保证像是获取字符串长度这类简单操作会返回 “恰当” 的结果
//https://zh.wikipedia.org/wiki/Unicode
//https://www.ruanyifeng.com/blog/2007/10/ascii_unicode_and_utf-8.html



//Unicode，而非固定宽度
let single = "Pok\u{00E9}mon" // Pokémon
let double = "Poke\u{0301}mon" // Pokémon
(single, double)
(single.count, double.count)
single == double
single.unicodeScalars.count // 7
double.unicodeScalars.count // 8
let nssingle = single as NSString
nssingle.length // 7
let nsdouble = double as NSString
nsdouble.length // 8

nssingle == nsdouble // false
single.compare(double)
single.utf8.elementsEqual(double.utf8) // false


let chars: [Character] = [ "\u{1ECD}\u{300}", // ọ́
 "\u{F2}\u{323}", // ọ́
 "\u{6F}\u{323}\u{300}", // ọ́
 "\u{6F}\u{300}\u{323}" // ọ́
]
let allEqual = chars.dropFirst().allSatisfy { $0 == chars.first } // true
let zalgo = "s̼̐͗͜o̠̦̤ͯͥ̒ͫ́ͅo̽ͩ̃ 㸅͟ͅ 㸄͖̗n̢͔͖͇ͪ͑"
zalgo.count // 4
zalgo.utf8.count
zalgo.utf16.count // 36

// CR+LF 是单个字符
let crlf = "\r\n"
crlf.count // 1


let oneEmoji = "😀"
oneEmoji.count

let flags = "🇵🇬🇧🇸"
flags.count
let s = flags.unicodeScalars.map {
    "U+\(String($0.value,radix: 16,uppercase: true))"
}
print(s)


let family1 = "👨‍👩‍👧‍👦"
///序列中的颜文字则通过一个标量值为 U+200D 的不可见零宽连接字符 (zero-width joiner，ZWJ) 连接
let family2 = "👨\u{200D}👩\u{200D}👧\u{200D}"
let family3 = "👨\u{200D}👩\u{200D}👧\u{200D}👦"

family1 == family3
family1.count
family2.count
family3.count


family1.count // 1
family1.utf16.count // 11
family1.utf8.count // 25


//字符串和集合
///String 是 Character 值的集合
///

let fagLetterC = ""
let fagLetterN = ""
let fag = fagLetterC + fagLetterN
fag.count // 1
fag.count == fagLetterC.count + fagLetterN.count // false


//双向索引，而非随机访问

