//
//  ZJBaseTableViewCell.m
//  iOSResponserChainDemo
//
//  Created by ZhouJian09 on 2021/9/30Thursday.
//  Copyright © 2021 chooingSl Inc. All rights reserved.
//

#import "ZJBaseTableViewCell.h"

@implementation ZJBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)indentifier{
    return @"ZJBaseTableViewCellKey";
}

@end
