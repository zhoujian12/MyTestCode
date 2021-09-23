//
//  ZJTableViewCell.h
//  iOSResponserChainDemo
//
//  Created by ZhouJian09 on 2021/9/23Thursday.
//  Copyright © 2021 chooingSl Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJTableViewCell : UITableViewCell

+ (NSString *)indentifier;

- (void)configTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
