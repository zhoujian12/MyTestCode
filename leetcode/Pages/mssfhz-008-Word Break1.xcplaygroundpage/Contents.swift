//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

//https://leetcode-cn.com/problems/word-break/solution/139-word-break-by-bento-lypt/

class Solution {
    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        var dp = Array(repeating: false, count: s.count + 1)
        dp[0] = true
        for i in 1 ..< dp.count {
            for word in wordDict {
                ///这个条件很精妙, dp[i - word.count] == true 为一个切割段条件
                if word.count <= i && dp[i - word.count] {
                    let startIndex = s.index(s.startIndex, offsetBy: i - word.count)
                    let endIndex = s.index(s.startIndex, offsetBy: i)
                    let subStr = s[startIndex ..< endIndex]
                    if subStr == word {
                        dp[i] = true
                        break
                    }
                }
            }
        }
        if let re = dp.last{
            return re
        }else{
            print("haha")
            return false
        }
    }
}

let s = Solution()
//let wordDict = ["cats", "dog", "sand", "and", "cat"]
//s.wordBreak("leetcode",["leet", "code"])
//s.wordBreak("catsandog",wordDict)
s.wordBreak("applepenapple", ["apple", "pen"])
s.wordBreak("", ["apple", "pen"])

