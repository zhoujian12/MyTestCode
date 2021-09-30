//
//  ZJWkWebView.m
//  iOSResponserChainDemo
//
//  Created by ZhouJian09 on 2021/9/30Thursday.
//  Copyright © 2021 chooingSl Inc. All rights reserved.
//

#import "ZJWkWebView.h"

@implementation ZJWkWebView

/*
//WKCompositingView
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    //获取 hitTestView
    return [self _web_findDescendantViewAtPoint:point withEvent:event];
}

//其具体实现为：

//UIView(WKHitTesting)
- (UIView *)_web_findDescendantViewAtPoint:(CGPoint)point withEvent:(UIEvent *)event
{
    Vector<UIView *, 16> viewsAtPoint;

    //只收集符合位置等条件的非 WKCompositingView 类型的 view， 存到 viewsAtPoint 中
    WebKit::collectDescendantViewsAtPoint(viewsAtPoint, self, point, event);

//    ...

    //对这些收集的 view 再根据业务逻辑进行过滤，根据不同类别找到其目标View
    for (auto *view : WTF::makeReversedRange(viewsAtPoint)) {
        //对此类 view 做递归 hitTest
        if ([view conformsToProtocol:@protocol(WKNativelyInteractible)]) {
            //natively interactible
            CGPoint subviewPoint = [view convertPoint:point fromView:self];
            return [view hitTest:subviewPoint withEvent:event];
        }

        //对此类 view 直接返回本身，不递归查找子 view
        if ([view isKindOfClass:[WKChildScrollView class]]) {
            if (WebKit::isScrolledBy((WKChildScrollView *)view, viewsAtPoint.last())) {
                //child scroll view
                return view;
            }
        }
        //同上
        if ([view isKindOfClass:WebKit::scrollViewScrollIndicatorClass()] && [view.superview isKindOfClass:WKChildScrollView.class]) {
            if (WebKit::isScrolledBy((WKChildScrollView *)view.superview, viewsAtPoint.last())) {
                //scroll indicator of child scroll view
                return view;
            }
        }
        //ignoring other views
    }
    return nil;
}
*/

@end
