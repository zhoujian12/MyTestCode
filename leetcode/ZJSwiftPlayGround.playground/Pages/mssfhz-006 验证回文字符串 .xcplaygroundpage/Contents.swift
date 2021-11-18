//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

//class Solution {
//    func isPalindrome(_ s: String) -> Bool {
//        var result = true
//        let charArr = Array(s)
//        var (l,r) = (0,charArr.count - 1)
//        while l < r {
//            if charArr[l] != charArr[r] {
//                return false
//            }
//
//            l += 1
//            r -= 1
//        }
//        return result
//    }
//}

class Solution {
    func isPalindrome(_ s: String) -> Bool {
        var list: [UInt32] = []
        for c in s.uppercased().unicodeScalars {
            if (c.value >= 48 && c.value <= 57) || (c.value >= 65 && c.value <= 90) {
                list.append(c.value)
            }
        }
        var left = 0
        var right = list.count - 1
        while left < right {
            if list[left] != list[right] {
                return false
            }
            left += 1
            right -= 1
        }
        return true
    }
}

let s = Solution()
s.isPalindrome("")
s.isPalindrome("h")
s.isPalindrome("hah")
s.isPalindrome("haha")

