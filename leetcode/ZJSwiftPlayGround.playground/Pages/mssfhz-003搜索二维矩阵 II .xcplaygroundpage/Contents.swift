//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)

class Solution {
    ///矩阵的左下角开始比较（该二维数组类似于一棵排序二叉树，对于每个数来说，上方的数都小于它，右方的数都大于它，所以把左下角作为根节点开始比较）
    ///关键是发现规律，找到他的
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        var result = false
        var m = matrix.count ///列
        var n = matrix.count > 0 ? matrix[0].count : 0 ///行
        var (i,j) = (m - 1, 0) ///  左下角
        
        while i >= 0 , j < n{
            if matrix[i][j] == target {
                return true
            }else if matrix[i][j] > target{
                i = i - 1
            } else {
                j = j + 1
            }
        }
        return result
    }
}
