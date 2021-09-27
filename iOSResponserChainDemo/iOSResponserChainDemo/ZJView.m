//
//  ZJView.m
//  iOSResponserChainDemo
//
//  Created by ZhouJian09 on 2021/9/24Friday.
//  Copyright © 2021 chooingSl Inc. All rights reserved.
//

#import "ZJView.h"

@implementation ZJView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog( @"ZJDebug - ZJView - touchesBegan touches: %@ ",touches);
    NSLog( @"ZJDebug - ZJView - touchesBegan touches: %p ",&touches);

}
@end
