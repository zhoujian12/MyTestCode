//
//  main.m
//  iOSResponserChainDemo
//
//  Created by 周健 on 2021/9/16Thursday.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ZJPerson.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
        
        // test different between new and alloc
        ZJPerson *z1 = [ZJPerson new];
        ZJPerson *z2 = [[ZJPerson alloc] init];
        
        
        
        
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
