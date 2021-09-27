//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

class Solution {
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {

        if m == 0 && n == 0{
            
        }else if m == 0 || n == 0{
            nums1 = m == 0 ? nums2 : nums1
        }else{
            var (i,j,k) = (m - 1,n - 1,m + n - 1)
            while j >= 0  {
//                print("1--i:\(i) j:\(j) nums1[i]:\(nums1[i]) nums2[j]:\(nums2[j])")
                if i >= 0 && nums1[i] > nums2[j]  {
                    nums1[k] = nums1[i]
                    i = i - 1
                }else{
                    nums1[k] = nums2[j]
                    j = j - 1
                }
                k = k - 1
            }
        }

    }
}

let s = Solution()
var nums1 = [2,0]
var m = 1
var nums2 = [1]
var n = 1

//var nums1 = [4,5,6,0,0,0]
//var m = 3
//var nums2 = [1,2,3]
//var n = 3

s.merge(&nums1, m, nums2, n)
print("4--nums1:\(nums1)")
