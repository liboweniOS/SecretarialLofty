//
//  SpecialTableViewCell.m
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "SpecialTableViewCell.h"

@implementation SpecialTableViewCell

@synthesize sm=_sm;//重写属性

#pragma mark-创建cell执行的方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self layoutCell];
    }
    return self;
}


#pragma mark-cell布局
-(void)layoutCell
{
    //一级页面图片
    self.yImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 130)];
   // self.yImageView.backgroundColor=[UIColor orangeColor];
    //边框
    self.yImageView.layer.borderColor=[UIColor whiteColor].CGColor;
    self.yImageView.layer.borderWidth=4;
    self.yImageView.layer.cornerRadius=20;//圆角
    self.yImageView.layer.masksToBounds=YES;//切掉边框之外的
    [self.contentView addSubview:self.yImageView];
    
    //一级页面标题
    self.yTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 130, [UIScreen mainScreen].bounds.size.width, 30)];
    //self.yTitleLabel.backgroundColor=[UIColor greenColor];
    self.yTitleLabel.textAlignment=NSTextAlignmentCenter;//居中
    [self.yTitleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];//加粗
    [self.contentView addSubview:self.yTitleLabel];
    
}


#pragma mark-重写set
-(void)setSm:(SpecialModel *)sm
{
    self.yImageView.image=[UIImage imageNamed:sm.yimageName];
    self.yTitleLabel.text=sm.ytitle;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
