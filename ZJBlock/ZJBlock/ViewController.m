//
//  ViewController.m
//  ZJBlock
//
//  Created by zhoujian on 2020/1/6.
//  Copyright © 2020 choosingSl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

int age = 1;
static int height = 1;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    int buttonCount = 5;
    for (int i = 0; i < buttonCount; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 200, 50);
        button.center = CGPointMake(self.view.frame.size.width / 2, i * 60 + 160);
//        button.tag = pow(1, i);
        button.tag = i;
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button setTitle:[NSString stringWithFormat:@"run (%d)",(int)button.tag] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
}

- (void)tap:(UIButton *)sender {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //[self test:(int)sender.tag];
        
        if ((int)sender.tag == 0) {
            [self test1];
        }else if ((int)sender.tag == 1){
            [self test2];
        }else if ((int)sender.tag == 2){
            [self test3];
        }else if ((int)sender.tag == 3){
            [self test4];
        }
    });
                   
}

- (void)test1{
    int i = 1;
    __block int j = 1;
    //无参无返回值 定义 和使用;
    // 只能捕获闭包函数 前的变量，不能捕获闭包后面的参数
    void (^ZJBlockOnce) (void) = ^{
        NSLog(@"无参无返回值");
        //        i = 2;
        j = 2;
        //        m = 2;
        //        n = 2;
        //      NSLog(@"i: %ld  j: %ld  m:%ld n: %ld", i,j,m,n);
        NSLog(@"i: %d  j: %d ", i,j);
    };
    
//    int m = 1;
//    __block int n = 1;
    // 调用
    ZJBlockOnce();
    
}

- (void)test2{
    int i = 1;
    __block int j = 1;
    //无参无返回值 定义 和使用;
    // __block 修饰后的数据才可以在block中被修改
    void (^ZJBlockOnce) (void) = ^{
        NSLog(@"i: %d  j: %d  ", i,j);
    };
    
    i = 3;
    j = 3;
    // 调用
    ZJBlockOnce();
}

- (void)test3{
    int i = 1;
    __block int j = 1;

    //dispatch_get_main_queue() 会优先让主线程中的任务先执行,然后在执行主队列中的任务
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"i: %d  j: %d  ", i,j);
    });
    
    i = 3;
    j = 3;
    
}

- (void)test4{
    static int j = 1;

    void (^ZJBlockOnce) (void) = ^{
        NSLog(@"  j: %d  age: %d  height: %d", j, age ,height);
    };
    
    j = 3;
    age = 3;
    height = 3;
    // 调用
    ZJBlockOnce();
}



@end
