//
//  SecondCategoriesTableViewCell.m
//  SecretarialLofty
//
//  Created by 康辰 on 15/7/10.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "SecondCategoriesTableViewCell.h"

@interface SecondCategoriesTableViewCell ()

@property (nonatomic, assign) NSInteger number;

@end
#define kMign 5
#define kScreen [UIScreen mainScreen].bounds.size
#define kFrame self.frame.size
@implementation SecondCategoriesTableViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    [self addAllView];
    }
    return  self;
}

- (void)addAllView
{
    _setimageView = [[UIImageView alloc] initWithFrame:CGRectMake(kMign, kMign, kFrame.width * 0.3, kFrame.height * 2)];
    _setimageView.layer.borderColor=[UIColor whiteColor].CGColor;
    _setimageView.layer.borderWidth=3;
    _setimageView.layer.cornerRadius=15;
    _setimageView.layer.masksToBounds=YES;

    [self addSubview: _setimageView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_setimageView.frame) + 10 , kMign, kScreenSize.width - CGRectGetWidth(_setimageView.frame) - 30, 40)];
    [self.nameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    self.nameLabel.numberOfLines=0;//可多行显示
    self.nameLabel.lineBreakMode=NSLineBreakByWordWrapping;//换行
    [self addSubview: _nameLabel];
    
    _intorLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_setimageView.frame) + 10, CGRectGetMaxY(_nameLabel.frame) + 5, kScreenSize.width - CGRectGetWidth(_setimageView.frame) - 20, 25)];
    _intorLabel.numberOfLines = 0;
    self.intorLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview: _intorLabel];
    
    self.collectButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_setimageView.frame) + 10, CGRectGetMaxY(_intorLabel.frame) + 3, 25, 25)];
    [self.collectButton setImage:[UIImage imageNamed:@"navCollect"] forState:UIControlStateNormal];
    
  //  [_collectButton addTarget:self action:@selector(buttonAction:modelNumber:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_collectButton];
}


//- (void)buttonAction:(UIButton *)sender
//         modelNumber:(NSInteger (^)(NSInteger a))mudelNumber;
//{
////    NSInteger (^bss)(NSInteger, NSInteger) = ^(NSInteger a, NSInteger b){
////        return a + b;
////    };
//    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"收藏成功" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:nil, nil];
//    [alertView show];
//}

@end



















