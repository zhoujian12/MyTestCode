//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

var hh = ["0"]
var ww = hh[0..<0]
print(ww,ww.count)

///二叉树定义
public class TreeNode{
    public var val: Int ///数据，也可以是NSObject
    public var left: TreeNode? ///左子树
    public var right: TreeNode? ///右子树
    ///不同参数的初始化方法
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}


/*
 根据一棵树的中序遍历与后序遍历构造二叉树。

 注意:
 你可以假设树中没有重复的元素。
前序：中左右 中序：左中右  后序：左右中
 
 例如，给出

 中序遍历 inorder = [9,3,15,20,7]
 后序遍历 postorder = [9,15,7,20,3]
 返回如下的二叉树：

     3
    / \
   9  20
     /  \
    15   7

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/construct-binary-tree-from-inorder-and-postorder-traversal
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
class Solution {
    ///递归
    func buildTree(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
        //获取中序数组的长度
        let len = inorder.count // 5 // 1 //3 //1
        //当中序数组的长度不等于后序数组的长度 ｜｜ 中序数组的长度小于1时即递归到左子树
        if len != postorder.count || len < 1 { return nil } //len != postorder.count是做一个容错，没有也可以
        var left = 0 // 中序数组中根节点的位置
        while inorder[left] != postorder[len - 1] {
            //遍历中序数组查找到根节点的下标位置
            left += 1 //left = 1 // left = 1
        }
        //设置根节点的数据为后序遍历的最后一个数据（由后序的特性决定）
        let root = TreeNode(postorder[len - 1]) // r:3 //r: 20 //15 //7
        // 左节点内容为中序数组中小于根节点索引的所有元素//[9] [9] // left: 9 //[15] [15]
        root.left = buildTree(Array(inorder[0..<left]), Array(postorder[0..<left]))
        // 右节点内容为中序数组中大于根节点索引的所有元素//[15,20,7] [15,7,20] //[7] [7]
        root.right = buildTree(Array(inorder[left+1..<len]), Array(postorder[left..<len-1]))
        return root
    }
}

//https://leetcode-cn.com/problems/construct-binary-tree-from-inorder-and-postorder-traversal/solution/jin-xu-10xing-dai-ma-qing-xi-yi-dong-by-huan-le-ma/

