////: [Previous](@previous)
//
//import Foundation
//
////动态规划
//
//class Solution{
//    func isMatch(_ m: String, _ n: String) -> Bool {
//        if m.isEmpty && n.isEmpty { //主串和模式串都为空
//            return true
//        }
//        var rows = m.count    //i //区间 [0,rows-1]
//        var cloumns = n.count //j //区间 [0,cloumns-1]
//        var cArr = [Bool](repeating: false  count: cloumns+1)
//        var dp = [Bool](repeating: cArr  count: rows+1)
//        
//        var s = Array(m)
//        var p = Array(n)
//        
//        
//        
//        for i in 0...rows {
//            for j in 0...cloumns {
//                if j == 0 { //空正则
//                    //初始条件 空串和空正则是匹配的 f[0][0] = true
//                    //非空串和非空正则必不匹配 f[1][0] = ... = f[n][0] = flase
//                    dp[i][j] = i == 0
//                }else{//非空正则
//                    //是否有*
//                    if p[j-1] != "*" { //最后一位不是"*"
//                        //
//                        if i > 0 && (s[i-1] == p[j-1] || p[j-1] == ".") {
//                            dp[i][j] == dp[i-1][j-1] //状态转移
//                        }
//                    }
//                }
//            }
//        }
//        
//        
//        
//        return false
//    }
//    
//}
//
//var s = Solution.init()
//s.isMatch("","")
//
//
//
