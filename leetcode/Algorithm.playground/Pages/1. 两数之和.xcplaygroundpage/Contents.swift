//: [Previous](@previous)

import Foundation

var str = "Hello, playground"


/*
给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出 和为目标值 的那 两个 整数，并返回它们的数组下标。

你可以假设每种输入只会对应一个答案。但是，数组中同一个元素不能使用两遍。

你可以按任意顺序返回答案。


示例 1：

输入：nums = [2,7,11,15], target = 9
输出：[0,1]
解释：因为 nums[0] + nums[1] == 9 ，返回 [0, 1] 。
示例 2：

输入：nums = [3,2,4], target = 6
输出：[1,2]
示例 3：

输入：nums = [3,3], target = 6
输出：[0,1]
*/

import Foundation

var str = "Hello, playground"

class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dict = [Int:Int]()
        
        for (i, n) in nums.enumerated() {
            dict[n] = i //hash表
        }
        
        for (i, n) in nums.enumerated() {
            if let index = dict[target - n] {
                if index != i { //数组中同一个元素不能使用两遍
                    return [i, index]
                }
            }
        }
        
        return []
    }
}

let nums = [2,7,11,15]
let s = Solution()
let arr = s.twoSum(nums,9)

//比twoSum更优化一些
func twoSum2(_ nums: [Int], _ target: Int) -> [Int] {
        var dict = [Int:Int]()
        for (i, n) in nums.enumerated() {
            if let index = dict[target - n] {
                return [index, i]
            }
            //不用存储所有的元素，只需存储当前及之前的元素，也避免的重复元素的问题
            dict[n] = i
        }
        
        return []
    
}

let nums2 = [2,7,11,15]
let arr2 = twoSum2(nums,9)
