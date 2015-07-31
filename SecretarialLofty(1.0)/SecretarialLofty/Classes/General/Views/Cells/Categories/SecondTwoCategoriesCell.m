//
//  SecondTwoCategoriesCell.m
//  SecretarialLofty
//
//  Created by 康辰 on 15/7/14.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "SecondTwoCategoriesCell.h"

@implementation SecondTwoCategoriesCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllView];
    }
    return self;
}

- (void)addAllView
{
    self.showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 0.8)];
    _showImageView.layer.borderColor=[UIColor whiteColor].CGColor;
    _showImageView.layer.borderWidth=5;
    _showImageView.layer.cornerRadius=30;
    _showImageView.layer.masksToBounds=YES;
    [self addSubview:_showImageView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height * 0.8, self.frame.size.width, self.frame.size.height * 0.1)];
    [self.nameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    self.nameLabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_nameLabel];
    
    self.induceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height * 0.9, self.frame.size.width, self.frame.size.height * 0.1)];
    self.induceLabel.font = [UIFont systemFontOfSize:13];

    [self addSubview:_induceLabel];
    
}

@end
