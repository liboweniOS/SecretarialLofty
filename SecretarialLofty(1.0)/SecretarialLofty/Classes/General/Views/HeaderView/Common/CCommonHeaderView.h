//
//  CCommonHeaderView.h
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/21.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Info;
@interface CCommonHeaderView : UITableViewHeaderFooterView

@property (nonatomic, retain) UIImageView *titleImageView;
@property (nonatomic, retain) UILabel *titlelabel;
@property (nonatomic, retain) UITextView *briefTextView;
@property (nonatomic, retain) UIImageView *authorImageView;
@property (nonatomic, retain) UILabel *authorLabel;

#pragma mark - 自定义初始化方法
- (instancetype)initWithFrame:(CGRect)frame
                     andInfo:(Info *)inffo;

@end
