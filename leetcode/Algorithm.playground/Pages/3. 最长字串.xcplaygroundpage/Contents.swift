//: [Previous](@previous)

import Foundation
import UIKit

/*
 给定一个字符串，请你找出其中不含有重复字符的 最长子串 的长度。

  

 示例 1:

 输入: s = "abcabcbb"
 输出: 3
 解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。
 示例 2:

 输入: s = "bbbbb"
 输出: 1
 解释: 因为无重复字符的最长子串是 "b"，所以其长度为 1。
 示例 3:

 输入: s = "pwwkew"
 输出: 3
 解释: 因为无重复字符的最长子串是 "wke"，所以其长度为 3。
      请注意，你的答案必须是 子串 的长度，"pwke" 是一个子序列，不是子串。
 示例 4:

 输入: s = ""
 输出: 0
  

 提示：

 0 <= s.length <= 5 * 104
 s 由英文字母、数字、符号和空格组成

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/longest-substring-without-repeating-characters
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */


func lengthOfLongestSubstring1(_ s: String) -> Int {
        if (s.count == 0) {
            return 0
        }
        var last = Array(repeating: -1, count: 128)
        var left = -1 //方便后面计算
        var ans = 0
        let unicode = s.unicodeScalars.map{Int($0.value)}
        print("unicode : \(unicode)")
        for i in 0...(unicode.count - 1) {
            left = max(left, last[unicode[i]])
            //借助了hash表
            /*
             left = 0  a["a"] = 0  ans = 1
             left = 1  a["b"] = 1  ans = 2
             left = 2  a["c"] = 2  ans = 3
             left = 2  a["a"] = 3  ans = 3
             left = 2  a["b"] = 4  ans = 0
             left = 2  a["c"] = 5  ans = 0
             left = 2  a["b"] = 6  ans = 0
             left = 2  a["b"] = 7  ans = 0
             */
            last[unicode[i]] = i
            ans = max(ans, i - left)
        }
        return ans
    }

//let str1 = "abcabcbb"
let str1 = "a"

let subStr = lengthOfLongestSubstring1(str1)

//滑动窗口，编写的Swift版本
func lengthOfLongestSubstring2(_ s: String) -> Int {
        if(s == ""){
            return 0
        }
        var maxStr = String()
        var curStr = String()
        for char in s{
            while curStr.contains(char) {
                curStr.remove(at: curStr.startIndex)
            }
            curStr.append(char)
            if(curStr.count > maxStr.count){
                maxStr = curStr
            }
        }
        return maxStr.count
    }

let str2 = "abcabcbb"

let subStr2 = lengthOfLongestSubstring2(str2)
