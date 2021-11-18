//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

class Solution {
            func addBinary(_ a: String, _ b: String) -> String {
                        return stringNumberAdd(a, second: b, base: 2)
                }
    
            func stringNumberAdd(_ first: String, second: String, base: Int8) -> String {
                if first == "" || first == "0" {
                            return second
                    }
                
                if second == "" || second == "0"{
                            return first
                    }
                
                var long: ContiguousArray<CChar>
                var short: ContiguousArray<CChar>
                
                if first.count >= second.count {
                            long = first.utf8CString
                            short = second.utf8CString
                    }else {
                                long = second.utf8CString
                                short = first.utf8CString
                        }
        print("1---long: \(long) short:\(short)")
                
                long.removeLast()
                short.removeLast()
                
                let countMax = long.count
                let countMin = short.count
                var carry: Int8 = 0
                
                for i in 0..<countMin {
                            var temp = long[countMax - i - 1] + short[countMin - i - 1] + carry - 96
                            carry = temp / base
            print("2--- temp: \(temp) carry:\(carry) temp: \(temp) carry:\(carry)")
                            temp %= base
                            long[countMax - i - 1] = temp + 48
            print("3--- temp: \(temp) long:\(long) ")

                    }
                
                for index in (0..<countMax - countMin).reversed() {
                            if carry == 0 {
                                        break
                                }
                            var temp = long[index] + carry - 48
                            carry = temp / base
                            temp %= base
                            long[index] = temp + 48
                    }
                
                if carry == 1 {
                            long.insert(49, at: 0)
                    }
                
                var result: String?
                long.withUnsafeBytes { ptr in
                            result = String.init(bytes: ptr, encoding: .utf8)
                    }
                
                return result ?? "0"
    }
}

let s = Solution()

s.addBinary("1010","1011")
s.addBinary("11","10")
s.addBinary("100","110010")
s.addBinary("1","111")



