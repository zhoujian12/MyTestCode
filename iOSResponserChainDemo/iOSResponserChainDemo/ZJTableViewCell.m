//
//  ZJTableViewCell.m
//  iOSResponserChainDemo
//
//  Created by ZhouJian09 on 2021/9/23Thursday.
//  Copyright © 2021 chooingSl Inc. All rights reserved.
//

#import "ZJTableViewCell.h"

@implementation ZJTableViewCell

+ (NSString *)indentifier {
    return @"ZJTableViewCellKey";
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubViews];
        self.contentView.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void)addSubViews{
    
}


- (void)configTitle:(NSString *)title{
    
//    self.titleLabel.text = title;
//    [self setLargeContentTitle:title];
    self.textLabel.text = title;
  
}

@end
