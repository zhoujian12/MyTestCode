//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

///摩尔投票法
class Solution {
    ///用相互抵消的思想，很是巧妙
    func majorityElement(_ nums: [Int]) -> Int {
        var major = nums[0];
        ///起始有值，所以这里会为1
        var count = 1;
        for  i in 1..<nums.count {
            if (count == 0) {
                //前面都消完了，在重新赋值
                print("1-- major:\(major) nums[i]:\(nums[i]) count:\(count)")
                count = count + 1
                major = nums[i];
                print("2-- major:\(major) nums[i]:\(nums[i]) count:\(count)")
            } else if (major == nums[i]) {
                //自己人，count就加1
                count = count + 1
                print("3-- major:\(major) nums[i]:\(nums[i]) count:\(count)")
            } else {
                //不是自己人就同归于尽，消掉一个
                count = count - 1
                print("4-- major:\(major) nums[i]:\(nums[i]) count:\(count)")
            }
        }
        print("5-- major:\(major)")
        return major;
    }
}

let s = Solution()
//s.majorityElement([2,2,1])
s.majorityElement([2,2,1,1,1])
