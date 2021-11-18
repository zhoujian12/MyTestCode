////: [Previous](@previous)
//
//import Foundation
//
//var greeting = "Hello, playground"
//
////: [Next](@next)
//
////参考仿写：https://leetcode-cn.com/problems/palindrome-partitioning/solution/hui-su-you-hua-jia-liao-dong-tai-gui-hua-by-liweiw/
//
/////解法1
////https://leetcode-cn.com/problems/palindrome-partitioning/solution/131-palindrome-partitioning-by-bento-ex8k/
////深度优先搜索方法+比较是否为对称字符串方法
/////记住回溯过程 要把原先add进数组的内容popLast出来
//
//class Solution {
//    func partition(_ s: String) -> [[String]] {
//        ///1. 创建可变结果数组
//        var res = [[String]]()
//        var temp = [String]()
//        
//        ///字符串为空直接返回
//        guard !s.isEmpty else { return res}
//        
//        dfs(s, 0, s.count, &temp, &res)
//        return res
//    }
//    func dfs(_ s: String,_ position :Int,_ len: Int, _ temp: inout [String], _ res: inout [[String]]) {
//        
//        if position == len - 1 {
//            ///当前为回文，加到当前的一次遍历中
//            res.append(temp)
//            print("5-- s:\(s) temp:\(temp) res:\(res)")
//        }
//        for i in position ..< len {
//            
//            let index = s.index(s.startIndex, offsetBy: i)
//            let substr = s[s.startIndex ... index]
//            print("1-- i:\(i) startIndex:\(s.startIndex) index: \(index)  substr:\(substr) temp: \(temp)")
//            
//            
//            if isPalindrome(String(substr)) {
//                let ss = s.index(s.startIndex, offsetBy: i)
//                let tailstr = s[s.index(after: index) ..< s.endIndex]
//                temp.append(String(substr))
//                print("2-- i:\(i) start:\(s.index(after: index)) ss:\(ss) temp:\(temp) tailstr:\(tailstr)")
//                dfs(s,i ,len, &temp, &res)
//                //减枝
//                print("3-- i:\(i) temp:\(temp)")
//                temp.popLast()
//                print("4-- i:\(i) temp:\(temp)")
//            }
//        }
//    }
//    func isPalindrome(_ s: String) -> Bool {
//        var i = 0, j = s.count - 1
//        let sArr = Array(s)
//        while i < j {
//            if sArr[i] != sArr[j] {
//                return false
//            }
//            i += 1
//            j -= 1
//        }
//        return true
//    }
//}
//
//let s = Solution()
//s.partition("aab")
