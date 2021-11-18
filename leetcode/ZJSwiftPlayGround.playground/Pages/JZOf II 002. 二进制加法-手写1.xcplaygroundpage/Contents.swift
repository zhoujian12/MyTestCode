//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

class Solution {
    func testFunc(_ a: String, _ b: String) -> Void {
        var (a,b) = (a.count >= b.count ? a : b,a.count >= b.count ? b : a )
        var aArr = Array(a)
        var bArr = Array(b)
        print("a:\(a) b:\(b)")

        //aArr[0]+aArr[1]:\(aArr[0] + aArr[1]
        print("aArr:\(aArr) aArr[0]:\(aArr[0]) \(aArr[0].asciiValue) \( Int(String(aArr[0] ))) \(String(aArr[0])) ")
        for i in (0...aArr.count - 1).reversed(){
            print("i : \(i)")
        }
        for i in (0...bArr.count - 1).reversed(){
            print("i : \(i)")
        }
        
        for i in (0..<(aArr.count - bArr.count)).reversed(){
            print("--i : \(i)")
        }
    }
    
    func addBinary(_ a: String, _ b: String) -> String {
         var (a,b) = (a.count >= b.count ? a : b,a.count >= b.count ? b : a )
         var aArr = Array(a)
         var bArr = Array(b)
         print("a:\(a) b:\(b)")
         let minCount = aArr.count > bArr.count ? bArr.count : aArr.count;
         var isNeedAdd = 0
         var re = ""
         for i in (0...bArr.count - 1).reversed(){
            let c = Int(String(aArr[i + aArr.count - bArr.count]))! +  Int(String(bArr[i]))!  + isNeedAdd
                 print("c : \(c) Int(String(aArr[i]))! : \(Int(String(aArr[i]))!)  Int(String(bArr[i]))! : \(Int(String(bArr[i]))!)  i:\(i) (i + aArr.count - bArr.count):\(i + aArr.count - bArr.count)" )
                 switch c{
                     case 0,1:
                         re = String(c) + re
                         print("c : \(c) re1: \(re)")

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
                  print("c : \(c) re2: \(re)")

             }

             if  (aArr.count == bArr.count){
                if  isNeedAdd > 0 {
                    re =  String("1") + re
                }

             }else{
                for i in (0..<(aArr.count - bArr.count)).reversed(){
                    print("--- i : \(i)")
                    print("--- i : \(i)")
                    let c = Int(String(aArr[i]))! + isNeedAdd
                    print("-- c : \(c) Int(String(aArr[i]))! : \(Int(String(aArr[i]))!)   i:\(i) " )

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
                    print("c : \(c) re3: \(re)")

                }
                if  isNeedAdd > 0 {
                    re =  String("1") + re
                }
             }
        print("re : \(re)")
             return re
    }
}

let s = Solution()
//s.testFunc("1010","1011")
s.testFunc("1","111")
//
//s.addBinary("1010","1011")
//s.addBinary("11","10")
//s.addBinary("100","110010")
s.addBinary("1","111")


