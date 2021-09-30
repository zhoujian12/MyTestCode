//
//  ZJWebViewController.m
//  iOSResponserChainDemo
//
//  Created by ZhouJian09 on 2021/9/30Thursday.
//  Copyright © 2021 chooingSl Inc. All rights reserved.
//

#import "ZJWebViewController.h"
#import <WebKit/WebKit.h>
#import "ZJWkWebView.h"
#import "ZJConfigInfo.h"

@interface ZJWebViewController ()

@property(nonatomic ,strong)WKWebView *webView;
@property(nonatomic ,strong)ZJWkWebView *wkWebView;

@end

@implementation ZJWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"ZJWebViewController";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.wkWebView];
    self.wkWebView.frame = CGRectMake(0, kNavigationBarBottom, kScreenWidth, kScreenHeight - kNavigationBarBottom - (kBottomSafeAreaHeight>0?20:0));
}

- (ZJWkWebView *)wkWebView{
    if (!_wkWebView) {
        _wkWebView = [[ZJWkWebView alloc] init];
        _wkWebView.backgroundColor = [UIColor blueColor];
    }
    return  _wkWebView;
}

@end
