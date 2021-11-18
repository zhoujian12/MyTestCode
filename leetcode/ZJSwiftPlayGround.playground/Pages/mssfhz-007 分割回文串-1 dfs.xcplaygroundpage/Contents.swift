//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

//https://leetcode-cn.com/problems/palindrome-partitioning/solution/hui-su-you-hua-jia-liao-dong-tai-gui-hua-by-liweiw/

///解法1
//https://leetcode-cn.com/problems/palindrome-partitioning/solution/131-palindrome-partitioning-by-bento-ex8k/
//深度优先搜索方法+比较是否为对称字符串方法
///记住回溯过程 要把原先add进数组的内容popLast出来

class Solution {
    func partition(_ s: String) -> [[String]] {
        ///1. 创建可变结果数组
        var res = [[String]]()
        var temp = [String]()
        dfs(s, &temp, &res)
        return res
    }
    func dfs(_ s: String, _ temp: inout [String], _ res: inout [[String]]) {
        ///字符串为空直接返回
        guard !s.isEmpty else { return }
        
        if isPalindrome(s) {
            ///当前为回文，加到当前的一次遍历中
            let t = temp
            res.append(t + [s])
            print("5-- s:\(s) temp:\(temp) res:\(res)")
        }
        for i in 0 ..< s.count {
            
            let index = s.index(s.startIndex, offsetBy: i)
            let substr = s[s.startIndex ... index]
            print("1-- i:\(i) startIndex:\(s.startIndex) index: \(index)  substr:\(substr) temp: \(temp)")
            
            //减枝
            if isPalindrome(String(substr)) && i != s.count - 1{
                temp.append(String(substr))
                let tailstr = s[s.index(after: index) ..< s.endIndex]
                print("2-- i:\(i) start:\(s.index(after: index)) endIndex:\(s.endIndex) temp:\(temp) tailstr:\(tailstr)")
                ///深度遍历
                dfs(String(tailstr), &temp, &res)
                
                print("3-- i:\(i) temp:\(temp)")
                ///回溯
                temp.popLast()
                print("4-- i:\(i) temp:\(temp)")
            }
        }
    }
    
    ///判断是否为回文字符串
    func isPalindrome(_ s: String) -> Bool {
        var i = 0, j = s.count - 1
        let sArr = Array(s)
        while i < j {
            if sArr[i] != sArr[j] {
                return false
            }
            i += 1
            j -= 1
        }
        return true
    }
}

let s = Solution()
s.partition("aab")

/*
 class Solution {
     func partition(_ s: String) -> [[String]] {
         var res = [[String]]()
         var temp = [String]()
         dfs(s, &temp, &res)
         return res
     }

     func dfs(_ s: String, _ temp: inout [String], _ res: inout [[String]]) {
         ///字符串为空直接返回
         guard !s.isEmpty else { return }
         
         if isPalindrome(s) {
             ///当前为回文，加到当前的一次遍历中
             let t = temp
             res.append(t + [s])
         }
         for i in 0 ..< s.count {
             
             let index = s.index(s.startIndex, offsetBy: i)
             let substr = s[s.startIndex ... index]
             
             //减枝
             if isPalindrome(String(substr)) && i != s.count - 1{
                 temp.append(String(substr))
                 let tailstr = s[s.index(after: index) ..< s.endIndex]
                 ///深度遍历
                 dfs(String(tailstr), &temp, &res)
                 ///回溯
                 temp.popLast()
             }
         }
     }
     func isPalindrome(_ s: String) -> Bool {
         var i = 0, j = s.count - 1
         let sArr = Array(s)
         while i < j {
             if sArr[i] != sArr[j] {
                 return false
             }
             i += 1
             j -= 1
         }
         return true
     }
 }
 
 */
