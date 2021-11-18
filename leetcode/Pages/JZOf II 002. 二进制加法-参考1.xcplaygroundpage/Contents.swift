////: [Previous](@previous)
//
//import Foundation
//
//var greeting = "Hello, playground"
//
////: [Next](@next)
//
//class Solution {
//    func addBinary(_ a: String, _ b: String) -> String {
//         var (a,b) = (a.count >= b.count ? a : b,a.count >= b.count ? b : a )
//         var aArr = Array(a)
//         var bArr = Array(b)
//         var re = ""
//         var (i,j,c) = (a.count - 1,b.count - 1,0)
//         while(i>=0 || j>=0 || c != 0){
//             let ii = i > 0 ? Int(String(aArr[i]))! - 48 : 0;
//            print("ii : \(ii)")
//             i = i > 0 ? i - 1 : i;
//             let jj = j > 0 ? Int(String(aArr[j]))! - 48 : 0;
//             j = j > 0 ? j - 1 : j;
//            print("jj : \(jj)")
//             c = ii + jj + c;
//             re.append(String(c%2))
//             c/=2
//         }
////         re = re
//         return  re
//    }
//}
//
//let s = Solution()
//
//s.addBinary("1010","1011")
////s.addBinary("11","10")
////s.addBinary("100","110010")
////s.addBinary("1","111")
