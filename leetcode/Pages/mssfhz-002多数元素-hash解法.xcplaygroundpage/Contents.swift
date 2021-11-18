//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

class Solution {
    func majorityElement(_ nums: [Int]) -> Int {
        let r = 0
        var counts = Dictionary<Int, Int>()
//        let s:NSInteger = 1
        
        for i in 0..<nums.count{
            ///强制解包
            let cc:Int = counts[nums[i]] ?? 0
            let count = cc + 1
            print("i : \(i) count: \(count) nums[i]:\(nums[i]) cc:\(cc)")
            if count > nums.count/2 {
                return nums[i];
            }
            counts[nums[i]] = count
            print("counts : \(counts) ")
        }
        return r
    }
}

let s = Solution()
s.majorityElement([2,2,1])
s.majorityElement([2,2,1,1,1])
