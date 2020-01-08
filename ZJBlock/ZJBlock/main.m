//
//  main.m
//  ZJBlock
//
//  Created by zhoujian on 2020/1/6.
//  Copyright © 2020 choosingSl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        
          __block int height = 1;
            __block int number = 1;
        //    __block NSString *str = @"haha";
            void (^block)(void) =  ^{
                 height = 2;
                 number = 2;
        //         str = @"hehe";
                 NSLog(@"block内部修改之后 height = %d number = %d ",height , number);
             };
            
            NSLog(@"block.class = %@",[block class]);
            block();
             NSLog(@"block.class = %@",[block class]);
            NSLog(@"block调用完 height = %d number = %d ",height , number);
        
        
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    
//    int age = 20;
//    void (^block)(void) =  ^{
//         NSLog(@"age is %d",age);
//     };
//
//    block();
    
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
