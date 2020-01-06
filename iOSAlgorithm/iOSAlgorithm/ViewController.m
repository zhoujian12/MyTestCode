//
//  ViewController.m
//  iOSAlgorithm
//
//  Created by zhoujian on 2019/12/24.
//  Copyright © 2019 choosingSl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableArray *arr = [[NSMutableArray alloc]initWithObjects: @(1),@(2),@(5),@(5),@(9),@(4),@(3),@(7), nil];
//    NSArray *sortArr = [self quickSort:arr leftIndex:0 rightIndex:arr.count - 1];
    NSArray *sortArr = [self quickSortArray:arr withLeftIndex:0 andRightIndex:arr.count - 1];

    NSLog(@"sortArr : %@", sortArr);
}

- (NSArray *)quickSort:(NSMutableArray *)unSortArray leftIndex:(NSInteger)lindex rightIndex:(NSInteger)rIndex {
    NSInteger i = lindex; NSInteger j = rIndex;
    // 取中间的值作为一个支点
    NSNumber *pivot = unSortArray[(lindex + rIndex) / 2];
    NSLog(@"pivot : %@", pivot);
    //
    while (i <= j) {
        // 向左移动，直到找打大于支点的元素
        while ([unSortArray[i] integerValue] < [pivot integerValue]) {
            i++;
        }
        // 向右移动，直到找到小于支点的元素
        while ([unSortArray[j] integerValue] > [pivot integerValue]) {
            j--;
        }
        NSLog(@"i : %ld  j : %ld", i , j);
        // 交换两个元素，让左边的大于支点，右边的小于支点
        if (i <= j) {
            // 如果 i== j，交换个啥？

            if (i != j) {
                NSNumber *temp = unSortArray[i];
                unSortArray[i] = unSortArray[j];
                unSortArray[j] = temp;
            }
            i++;
            j--;
        }
    }
    // 递归左边，进行快速排序
    if (lindex < j) {
        [self quickSort:unSortArray leftIndex:lindex rightIndex:j];
    }
    // 递归右边，进行快速排序
    if (i < rIndex) {
        [self quickSort:unSortArray leftIndex:i rightIndex:rIndex];
    }
    return [unSortArray copy];
}


- (NSArray *)quickSortArray:(NSMutableArray *)array withLeftIndex:(NSInteger)leftIndex andRightIndex:(NSInteger)rightIndex
{
    if (leftIndex >= rightIndex) {//如果数组长度为0或1时返回
        return array;
    }
    
    NSInteger i = leftIndex;
    NSInteger j = rightIndex;
    //记录比较基准数
    NSInteger key = [array[i] integerValue];
    
    while (i < j) {
        /**** 首先从右边j开始查找比基准数小的值 ***/
        while (i < j && [array[j] integerValue] >= key) {//如果比基准数大，继续查找
            j--;
        }
        //如果比基准数小，则将查找到的小值调换到i的位置
        array[i] = array[j];
        
        /**** 当在右边查找到一个比基准数小的值时，就从i开始往后找比基准数大的值 ***/
        while (i < j && [array[i] integerValue] <= key) {//如果比基准数小，继续查找
            i++;
        }
        //如果比基准数大，则将查找到的大值调换到j的位置
        array[j] = array[i];
        
    }
    
    //将基准数放到正确位置
    array[i] = @(key);
    
    /**** 递归排序 ***/
    //排序基准数左边的
    [self quickSortArray:array withLeftIndex:leftIndex andRightIndex:i - 1];
    //排序基准数右边的
    [self quickSortArray:array withLeftIndex:i + 1 andRightIndex:rightIndex];
    
    return array;
}

@end
