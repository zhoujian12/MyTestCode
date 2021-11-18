//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

class Solution {
    func majorityElement(_ nums: [Int]) -> Int {
        var major = 0
        let len = nums.count
        ///通过 &运算和 ｜ 运算，获取到多数数字的二进制上的每一位，很巧妙
        var i = 0
        var mask = 1
        while i < 64 {
            var bitCount = 0
            for j in 0..<len {
                if nums[j] & mask == mask {
                    print("1--nums[j]: \(nums[j])  mask:\(mask)")
                    bitCount = bitCount + 1
                }
//                print("2--bitCount: \(bitCount)")
                if bitCount > len/2 {
                    print("2--major: \(major) mask:\(mask)")
                    major = major | mask
                    print("3--major: \(major)")
                    break
                }
            }
            mask = mask << 1
            i = i + 1
        }
        
        return major
    }
}

let s = Solution()
//s.majorityElement([2,2,1])
//s.majorityElement([2,2,1,1,1])
s.majorityElement([5,4,3,0,0])
//s.majorityElement([-5])

//s.majorityElement([5,4,3,7,7])




//class Solution {
//    func majorityElement(_ nums: [Int]) -> Int {
//        var major = 0
//        if (nums.count == 1){
//            return nums.first ?? 0
//        }
//
//        var i = 0
//        var u = 1
//        while(i < 32){
//            var bitCount = 0
//             for j in 0..<nums.count{
//                 if nums[j] & u == u {
//                     bitCount = bitCount + 1
//                 }
//
//                 if bitCount > nums.count/2{
//                     major = u | major
//                     break
//                 }
//             }
//             i = i + 1
//             u = u << 1
//
//        }
//        return major
//    }
//}
