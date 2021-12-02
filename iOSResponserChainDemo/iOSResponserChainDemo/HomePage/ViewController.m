//
//  ViewController.m
//  iOSResponserChainDemo
//
//  Created by 周健 on 2021/9/16Thursday.
//
/*
 
 事件的传递和响应机制 https://www.jianshu.com/p/2e074db792ba
 消息传递机制 https://objccn.io/issue-7-4/
 */

#import "ViewController.h"
#import "ZJTableViewCell.h"
#import "ZJView.h"
#import <objc/runtime.h>
#import "ZJBaseTableViewCell.h"
#import "ZJConfigInfo.h"
#import "ZJWebViewController.h"
#import "ZJPerson.h"


static const NSInteger kItemCount = 4;

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;
@property(nonatomic ,strong)UIView *myView;
@property (nonatomic, assign) NSInteger isRefer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ViewController";
    
//    dispatch_queue_set_specific(dispatch_get_main_queue(), key, @"main", NULL);

    //异步加入到全局并发队列中
     dispatch_async(dispatch_get_global_queue(0, 0), ^{
    //异步加入到主队列中
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"main thread: %d", [NSThread isMainThread]);
                NSLog(@"2---%@",[NSThread currentThread]);
                // 判断是否是主队列
//                void *value = dispatch_get_specific(key);//返回与当前分派队列关联的键的值。
//                NSLog(@"main queue: %d", value != NULL);
            });
        });
     
    NSLog(@"1---%@",[NSThread currentThread]);

        NSLog(@"dispatch_main会堵塞主线程");
//        dispatch_main();
        NSLog(@"查看是否堵塞主线程");
    return;
    
    for (id obj in @[@0,@1,@2,@3,@4,@5,@6,@7,@8,@9]) {
        NSLog(@"obj: %@ - (long)self.isRefer:%ld true or false:%@ self.isRefer:%@",obj,(long)self.isRefer,self.isRefer == 0 ? @YES : @NO,self.isRefer);
        
    }
    return;
    
    ZJPerson *p1 = [self fetchPersonData];
    NSLog(@"p1.name : %@",p1.name);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)) , dispatch_get_main_queue(), ^{
        NSLog(@"p1.name --1 : %@",p1.name);
    });
    return;
    // Do any additional setup after loading the view.
    
    //打印堆栈信息
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    //        NSLog(@"[NSThread callStackSymbols] : %@",[NSThread callStackSymbols]);
    //    });
    
    
    ///为什么UIcontrol 的事件会拦截掉 UIResponser的事件，因为，其内部方法重写了touch事件
    
    unsigned int methodCount = 0;
    Method *methods = class_copyMethodList([UIControl class], &methodCount);
    for (int i = 0; i<methodCount; i++) {
        //         NSLog(@"方法名称:%s",sel_getName(method_getName(methods[i])));
        //         NSLog(@"方法Types:%s",method_getDescription(methods[i])->types);
    }
    free(methods);
    
    
    self.myView = [[ZJView alloc] initWithFrame:self.view.frame];
    //    self.view = self.myView;
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + kZJStatusBarHeight, self.view.frame.size.width, self.view.frame.size.height - kZJStatusBarHeight) ;
    [self.tableView reloadData];
}

- (ZJPerson *)fetchPersonData{
//    ZJPerson *p = [[ZJPerson alloc] init];
    ZJPerson *p = [ZJPerson new];
    NSLog(@"p.name : %@",p.name);
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)) , dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        p.name = @"haha";
        NSLog(@"p.name --1 : %@",p.name);
        dispatch_semaphore_signal(signal);
    });
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    return p;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ///cell == nil 没有用
    UITableViewCell *cell = nil;
    if (indexPath.row < 3) {
        ZJTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:ZJTableViewCell.indentifier forIndexPath:indexPath];
        
        cell1.selectionStyle = UITableViewCellSelectionStyleGray;
        id title = [self.dataArr objectAtIndex:indexPath.row];
        if([title isKindOfClass:[NSString class]]){
            NSString *t = (NSString *)title;
            [cell1 configTitle:t num:indexPath.row];
        }
        cell = cell1;
    }else{
        ZJBaseTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:ZJBaseTableViewCell.indentifier forIndexPath:indexPath];
        id title = [self.dataArr objectAtIndex:indexPath.row];
        if([title isKindOfClass:[NSString class]]){
            NSString *t = (NSString *)title;
            cell2.textLabel.text = t;
        }
        cell = cell2;
    }
    
    
    return cell ?: [[UITableViewCell alloc] init];
}

#pragma mark - didSelectRowAtIndexPath action
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //这里没有调用，后续有时间可以排查一下
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog( @"ZJDebug - didSelectRowAtIndexPath section-row:%ld-%ld ",(long)indexPath.section,(long)indexPath.row);
    
    if (indexPath.row == 3) {
        ZJWebViewController *v = [[ZJWebViewController alloc] init];
        [self.navigationController pushViewController:v animated:NO];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 3) {
        return 100;
    }else{
        return 44;
    }
    
}

#pragma mark - getter && setter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        //不允许滑动和弹动效果
        _tableView.bounces = NO;
        _tableView.scrollEnabled = NO;
        _tableView.allowsSelection = true;
        _tableView.allowsMultipleSelection = YES;
        _tableView.delaysContentTouches = false;
        _tableView.estimatedRowHeight = 44;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_tableView registerClass:ZJTableViewCell.class forCellReuseIdentifier:ZJTableViewCell.indentifier];
        [_tableView registerClass:ZJBaseTableViewCell.class forCellReuseIdentifier:ZJBaseTableViewCell.indentifier];
    }
    return  _tableView;
}

- (NSArray *)dataArr{
    if (!_dataArr) {
        NSArray *desArr = @[@"title1",@"title2",@"title3",@"WebKit touch"];
        NSMutableArray *arr = @[].mutableCopy;
        for (int i = 0; i < desArr.count; ++i) {
            [arr addObject:[NSString stringWithFormat:@"%d - %@",i, desArr[i]] ];
        }
        _dataArr = arr.copy;
    }
    return  _dataArr;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //    NSLog( @"ZJDebug - touchesBegan touches: %@ ",touches);
    NSLog( @"ZJDebug - VC - touchesBegan touches: %p ",&touches);
}


@end
