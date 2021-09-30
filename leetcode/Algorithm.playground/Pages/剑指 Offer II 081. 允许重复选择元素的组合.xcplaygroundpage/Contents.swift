//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
class Solution {
    ///回溯算法
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        ///线索一 正整数
        var lists = [[Int]]()
        var one = [Int]()
        ///使用指针传入，避免生成临时变量和返回值
        dfs(lists: &lists, one: &one, candidates: candidates, target: target, p: 0)
        return lists
    }
    
    func dfs( lists:inout [[Int]], one:inout [Int], candidates: [Int] , target: Int, p: Int) {
//        var (one,lists) = (one,lists)
//        var one = one
        ///回溯的判断终止条件
        if (target <= 0){
            if (target == 0){
                print("one4 : \(one)")
                
                lists.append(one)
                print("lists3 : \(lists)")
            }
            return

        }
        
        ///截取切片数组arr[i...j]
        for (i,value) in candidates[p...candidates.count-1].enumerated(){
//            if one.count > 150 {
//                return
//            }
            ///由于swift 不支持常规的for 循环了...所以这么做
            let j = i + p
            print("i : \(i) j: \(j) p: \(p)  value: \(value)")
            one.append(value)
            print("one1 : \(one)")
            print("lists1 : \(lists)")
            dfs(lists: &lists, one: &one, candidates: candidates, target: target - value, p: j)
            print("lists2 : \(lists)")
            print("one2 : \(one)")
            
            ///这个是重点，做剪枝的操作
            one.remove(at: one.count - 1)
            print("lists4 : \(lists)")
            print("one3 : \(one)")

        }
        
        
        
    }
}

let s = Solution()
s.combinationSum([2,3,6,7],7)

