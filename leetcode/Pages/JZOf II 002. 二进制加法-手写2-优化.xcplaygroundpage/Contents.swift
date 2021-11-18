//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

class Solution {
   
    
    func addBinary(_ a: String, _ b: String) -> String {
         let (a,b) = (a.count >= b.count ? a : b,a.count >= b.count ? b : a )
        let aArr = Array(a.reversed())
        let bArr = Array(b.reversed())
         print("a:\(a) b:\(b)")
         var isNeedAdd = 0
         var re = ""
         for i in (0...bArr.count - 1){
            let c = Int(String(aArr[i]))! +  Int(String(bArr[i]))!  + isNeedAdd
                switch c{
                     case 0,1:
                         re = String(c) + re
                         isNeedAdd = 0
                     case 2:
                         re = String("0") + re
                         isNeedAdd = 1
                    case 3:
                         re = String("1") + re
                         isNeedAdd = 1
                     default:
                     break
                 }
             }

             if  (aArr.count == bArr.count){
                if  isNeedAdd > 0 {
                    re =  String("1") + re
                }

             }else{
                for i in (bArr.count..<aArr.count) {
                    let c = Int(String(aArr[i]))! + isNeedAdd
                    switch c{
                    case 0,1:
                        re = String(c) + re
                        isNeedAdd = 0
                    case 2:
                        re = String("0") + re
                        isNeedAdd = 1
                   case 3:
                        re = String("1") + re
                        isNeedAdd = 1
                    default:
                    break
                    }
                }
                if  isNeedAdd > 0 {
                    re =  String("1") + re
                }
             }
             return re
    }
}

let s = Solution()

s.addBinary("1010","1011")
s.addBinary("11","10")
s.addBinary("100","110010")
s.addBinary("1","111")


