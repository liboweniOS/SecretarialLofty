//
//  LBWCellHeaderView.m
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/10.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "LBWCellHeaderView.h"

#define kLeftScreenSize (leftImageView.frame.size)
#define kLeftScreenOrigin (leftImageView.frame.origin)
@interface LBWCellHeaderView ()

@property (nonatomic, retain) UILabel *leftLabel;

@end

@implementation LBWCellHeaderView

#pragma mark - 自定义初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addAllViews];
        
    }
    return self;
}

#pragma mark - 自定义方法
#pragma mark addAllViews
- (void)addAllViews
{
    UIImageView *leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellHead.png"]];
    leftImageView.frame = CGRectMake(0, 6, 20, 20);

    [self addSubview:leftImageView];
    
    self.leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLeftScreenSize.width + kLeftScreenOrigin.x * 2, 0, 80, 35)];
    [self addSubview:_leftLabel];
    
    _leftLabel.textColor = [UIColor colorWithRed:1.000 green:0.642 blue:0.558 alpha:1.000];
    
    _leftLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_rightButton setImage:[UIImage imageNamed:@"bg_more_category.png"] forState:UIControlStateNormal];
    _rightButton.frame = CGRectMake(kScreenSize.width - 50, 0, 45, 35);
    [self addSubview:_rightButton];
}

- (void)setLeftLabelText:(NSString *)leftLabelText
{
    if (_leftLabelText != leftLabelText) {
        _leftLabelText = nil;
        _leftLabelText = [leftLabelText copy];
        // 赋值
        _leftLabel.text = leftLabelText;
    }
}

@end
