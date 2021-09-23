//
//  ViewController.m
//  iOSResponserChainDemo
//
//  Created by 周健 on 2021/9/16Thursday.
//

#import "ViewController.h"
#import "ZJTableViewCell.h"

static const NSInteger kItemCount = 4;

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    id title = [self.dataArr objectAtIndex:indexPath.row];
    if([title isKindOfClass:[NSString class]]){
        NSString *t = (NSString *)title;
        [cell configTitle:t];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //这里没有调用，后续有时间可以排查一下
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog( @"ZJDebug - didSelectRowAtIndexPath section-row:%ld-%ld ",(long)indexPath.section,(long)indexPath.row);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
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
        _tableView.separatorStyle =UITableViewCellSeparatorStyleSingleLine;
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


@end
