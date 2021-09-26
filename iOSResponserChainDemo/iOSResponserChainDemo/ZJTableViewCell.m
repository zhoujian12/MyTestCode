//
//  ZJTableViewCell.m
//  iOSResponserChainDemo
//
//  Created by ZhouJian09 on 2021/9/23Thursday.
//  Copyright © 2021 chooingSl Inc. All rights reserved.
//

#import "ZJTableViewCell.h"

@interface ZJTableViewCell()

@property(nonatomic ,strong)UIButton *btn;
@property(nonatomic ,strong)UIButton *imageBtn;
@property(nonatomic ,strong)UIImageView *imgView;

@end

@implementation ZJTableViewCell

+ (NSString *)indentifier {
    return @"ZJTableViewCellKey";
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubViews];
        self.backgroundColor = [UIColor blackColor];
        self.contentView.backgroundColor = [UIColor orangeColor];
        // UIGestureRecognizer - NSObject
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self.contentView addGestureRecognizer:tap];
    }
    return self;
}

- (void)addSubViews{
    [self.contentView addSubview:self.btn];
    [self.contentView addSubview:self.imageBtn];
    [self.contentView addSubview:self.imgView];
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    NSLog(@"tapAction tap:%@",tap);
}

- (void)configTitle:(NSString *)title num:(NSInteger)num{

    self.textLabel.text = title;
//    self.detailTextLabel.text = title;
//    [self.contentView bringSubviewToFront:self.textLabel];
//    self.detailTextLabel.textColor = [UIColor blueColor];
    NSLog(@"self.detailTextLabel.text : %@ superView: %@",self.textLabel.text,self.textLabel.superview);
    
    [self.imageBtn setImage:[UIImage imageNamed:@"icon_home_search_top1"] forState:UIControlStateNormal];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog( @"ZJDebug - ZJTableViewCell - touchesBegan touches: %@ ",touches);
    // 1.自己先处理事件...
    NSLog( @"ZJDebug - ZJTableViewCell - touchesBegan touches: %p ",&touches);
    NSLog(@"do somthing...");
    // 2.再调用系统的默认做法，再把事件交给上一个响应者处理
    [super touchesBegan:touches withEvent:event];

}

- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btn.backgroundColor = [UIColor yellowColor];
        [_btn setTitle:@"btn" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _btn;
}

- (UIButton *)imageBtn{
    if (!_imageBtn) {
        _imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_imageBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _imageBtn.backgroundColor = [UIColor whiteColor];
//        [_imageBtn setTitle:@"btn" forState:UIControlStateNormal];
//        [_imageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _imageBtn;
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = [UIColor whiteColor];
        _imgView.image = [UIImage imageNamed:@"icon_home_search_top1"];
    }
    return _imgView;
}

- (void)btnClick:(UIButton *)btn{
    NSLog(@"ZJDebug - btnClick ");
}

- (void)layoutSubviews{
    //MARK: 这里重写父类方法很重要
    [super layoutSubviews];
    self.btn.frame = CGRectMake(100, 10, 50, 20);
    self.imageBtn.frame = CGRectMake(160, 10, 80, 80);
    self.imgView.frame = CGRectMake(250, 10, 80, 80);
}

@end
