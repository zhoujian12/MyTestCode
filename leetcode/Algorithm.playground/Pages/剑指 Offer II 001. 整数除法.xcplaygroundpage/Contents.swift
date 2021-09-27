//: [Previous](@previous)

import Foundation
import PlaygroundSupport


var str = "Hello, playground"

//: [Next](@next)

class Solution {
    
//    init() {
//        super.init()
////        self.divide(15, -2)
//    }
    
    func divide(_ a: Int, _ b: Int) -> Int {
        
        print("Int32.max: \(Int32.max)")
        //-Int32.min : Arithmetic operation '0 - -2147483648' (on signed 32-bit integer type) results in an overflow
        print("Int32.min: \(Int32.min)")
        print("0x40000000 : \(0x40000000)")
        print("0x80000000 : \(0x80000000)")
        print("0xc0000000 : \(0xc0000000)")
        print("0xa0000000 : \(0xa0000000)")
        print("0x7FFFFFFF : \(0x7FFFFFFF)")
        print("-0xc0000000 : \(-0xc0000000)")
        print("0x80000001 : \(0x80000001)")
        print("0x8000000F : \(0x8000000F)")
        print("0xFFFFFFFF : \(0x7FFFFFFF)")
        print("0xFFFFFFFE : \(0x7FFFFFFE)")

        
        //https://leetcode-cn.com/problems/xoh6Oh/solution/jian-zhi-offer-ii-001-zheng-shu-chu-fa-b-tt7v/
        //方法1，此方法超出了时间限制还需要优化。。。
        var (a,b) = (a,b)
        //assert(b == 0, "除数不能为0")
        ///直接用的16进制做的判断，比较巧妙；但也可以用Int32.max 之类的系统定义
        ///考虑溢出的情况，因为被除数和除数都是整数，所以溢出之存在这一种情况，需要观察题目的考察知识点和突破点
        if (a == 0x80000000 && b == -1){
            return 0x7FFFFFFF
        }

        ///判断正位数的个数，为什么？ 因为结果需要判断为正负
        ///为什么都要转换成负数来处理？ 因为方便做减法运算，这里很巧妙，不然要做很多判断来做减法运算
        var positiveNum = 2
        if (a > 0){
            positiveNum = positiveNum - 1
            a = -a
        }

        if (b > 0){
            positiveNum = positiveNum - 1
            b = -b
        }

        var result = 0
        ///循环常用while，感觉更方便
        while(a <= b){
            a -= b
            result += 1
        }
        return positiveNum == 1 ? -result : result

    }
    
    
}

let c = Solution.init()
let p = c.divide(15, -2)
