import UIKit
import Foundation

var str = "Hello, playground"


//class Solution {
let arr1 = [3,7,4,-1,1,-5,7]
/*
    - Positive（求缺失的第一个正数）
    英文版：https://leetcode.com/problems/first-missing-positive/
    中文版：https://leetcode-cn.com/problems/first-missing-positive/
 */
func firstMissingPositive(_ nums: [Int]) -> Int {
    //原地hash
    var arr = nums;
    let len = arr.count;
    for i in 0..<len{
        //    var exchange = arr[ arr[i] - 1];
        print(" 1--- len : \(len) ")
        while( arr[i] > 0 && (arr[i] - 1) < len &&  arr[ arr[i] - 1] != arr[i]){
            print(" 3--- arr[i] - 1 : \(arr[i] - 1)  i: \(i) \(arr[ arr[i] - 1]) ")
            let temp = arr[ arr[i] - 1];
            arr[ arr[i] - 1] = arr[i];
            arr[i] = temp;
            
            print(" 4--- arr : \(arr) ")
        }
    }
    for i  in 0..<len {
        print(" 2--- i : \(i) ")
        if (arr[i] != i+1){
            return i+1;
        }
    }
    return len + 1;
}

let a = firstMissingPositive(arr1)
print(a)

/*
    - Three  Sum（求三数之和）
    英文版：https://leetcode.com/problems/3sum/
    中文版：https://leetcode-cn.com/problems/3sum/Majority
*/


func threeSum(_ nums: [Int]) -> [[Int]] {
    var result = [[Int]]()
    
    if nums.count < 3{
        return result
    }
    
    let arr = nums.sorted()
    for  i in 0..<(arr.count - 2) {
        var l = i + 1;
        var r = arr.count - 1;
        
        while l < r {
            
            let first = arr[i]
            let target = 0 - first
            let temp = arr[l] + arr[r]
            
            if temp == target{
                result.append([arr[i],arr[l],arr[r]])
                l += 1
            }else if temp > target{
                r -= 1
                while r > 2 && arr[r] == arr[r - 1] {
                    r -= 1
                }
                
            }else{
                l += 1
                while l < arr.count - 2 && arr[l] == arr[l + 1]  {
                    l += 1
                }
            }
        }
    }
    
    return result
}
