//
//  CommonHeaderView.h
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/10.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Album;

@interface CommonHeaderView : UITableViewHeaderFooterView

@property (nonatomic, retain) UIImageView *titleImageView;
@property (nonatomic, retain) UILabel *title;
@property (nonatomic, retain) UITextView *briefTextView;
@property (nonatomic, retain) UIImageView *authorImageView;
@property (nonatomic, retain) UILabel *authorLabel;

#pragma mark - 自定义初始化方法
- (instancetype)initWithFrame:(CGRect)frame
                     andAlbum:(Album *)album;

@end
