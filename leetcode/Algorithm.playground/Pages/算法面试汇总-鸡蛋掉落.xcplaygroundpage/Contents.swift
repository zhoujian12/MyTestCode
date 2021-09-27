//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

// 题目： https://leetcode-cn.com/leetbook/read/top-interview-questions/xmup75/
// 题解： https://leetcode-cn.com/problems/super-egg-drop/solution/

// 方法一：动态规划 + 二分查找

//class Solution{
//    func superEggDrop(_ k: Int, _ n: Int) -> Int {
//        var memo = [Int:Int]()
//        return dp(k,n, &memo)
//    }
//
//    func dp(_ k: Int, _ n: Int, _ memo:inout [Int:Int]) -> Int {
//        if !(memo.keys.contains(n * 100 + k)) {
//            var ans = 0
//            if n == 0 {
//                ans = 0
//            }else if k == 1{
//                ans = n
//            }else {
//                var (lo,hi) = (1,n)
//                while lo + 1 < hi {
//                    let x = lo + hi / 2
//                    let t1 = dp(k - 1,x - 1,&memo)
//                    let t2 = dp(k, n - x,&memo)
//                    if t1 < t2 {
//                        lo = x
//                    }else if t1 > t2{
//                        hi = x
//                    }else{
//                        hi = x
//                        lo = x
//                    }
//                }
//                ans = 1 + min( max( dp(k - 1, lo - 1, &memo), dp(k, n - lo, &memo) ), max( dp(k - 1, hi - 1, &memo), dp(k, n - hi, &memo) )   )
//            }
//            print("n:\(n) k:\(k) ans: \(ans) memo:\(memo)")
//            memo[n * 100 + k] = ans
//            print("memo:\(memo)")
//        }
//
//        return memo[n * 100 + k] ?? 0
//    }
//
//}

class Solution {
    func superEggDrop(_ K: Int, _ N: Int) -> Int {
    var m = 0
    /// k + 1个数组
    var dp = Array(repeating: 0, count: K + 1)
    print("1-- dp:\(dp) dp[K]:\(dp[K]) N:\(N) K:\(K)")
    while(dp[K] < N) {
        print("2-- dp[K]:\(dp[K]) N:\(N)")
        m += 1
        print("3-- m:\(m)")

        for i in (1...K).reversed(){
            print("4-- i:\(i) dp[i]:\(dp[i])")
            dp[i] += 1 + dp[i - 1]
            print("5-- i:\(i) dp[i]:\(dp[i])")

        }
    }
       
        print("6-- dp:\(dp)")
    return m
    }
}

//作者：pointerluo
//链接：https://leetcode-cn.com/problems/super-egg-drop/solution/swift-by-pointerluo-4/
//来源：力扣（LeetCode）
//著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

let s = Solution()
s.superEggDrop(1,2) //2
s.superEggDrop(2,2) //2
s.superEggDrop(100,2) //2

s.superEggDrop(2,6) //3

s.superEggDrop(3,14) //4


