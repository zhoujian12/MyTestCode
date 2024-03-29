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

static const NSInteger kItemCount = 4;

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;
@property(nonatomic ,strong)UIView *myView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    self.view = self.myView;
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 64, self.view.frame.size.width, self.view.frame.size.height - 64) ;
    
//    self.dataArr = @[@"title1",@"title2",@"title3"];
//    _dataArr = self.dataArr;
    [self.tableView reloadData];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZJTableViewCell.indentifier forIndexPath:indexPath];
    if (cell == nil){
        cell = [[ZJTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ZJTableViewCell.indentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    id title = [self.dataArr objectAtIndex:indexPath.row];
    if([title isKindOfClass:[NSString class]]){
        NSString *t = (NSString *)title;
        [cell configTitle:t num:indexPath.row];
    }
    return cell;
}

#pragma mark - didSelectRowAtIndexPath action
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //这里没有调用，后续有时间可以排查一下
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog( @"ZJDebug - didSelectRowAtIndexPath section-row:%ld-%ld ",(long)indexPath.section,(long)indexPath.row);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 144;
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
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_tableView registerClass:ZJTableViewCell.class forCellReuseIdentifier:ZJTableViewCell.indentifier];
    }
    return  _tableView;
}

- (NSArray *)dataArr{
    if (!_dataArr) {
        NSArray *desArr = @[@"title1",@"title2",@"title3"];
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
