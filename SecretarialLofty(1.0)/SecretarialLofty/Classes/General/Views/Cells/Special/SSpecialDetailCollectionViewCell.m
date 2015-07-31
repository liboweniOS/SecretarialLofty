//
//  SSpecialDetailCollectionViewCell.m
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "SSpecialDetailCollectionViewCell.h"

@implementation SSpecialDetailCollectionViewCell

@synthesize sdm=_sdm;//重写属性

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
      
        //图片
        self.eesImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-70)];
        //边框
        self.eesImageView.layer.borderColor=[UIColor whiteColor].CGColor;
        self.eesImageView.layer.borderWidth=4;
        self.eesImageView.layer.cornerRadius=20;//圆角
        self.eesImageView.layer.masksToBounds=YES;//切掉边框之外的
        [self.contentView addSubview:self.eesImageView];
        
        //主题
        self.eesTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-70, self.bounds.size.width, 40)];
        [self.eesTitleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];//加粗
        self.eesTitleLabel.numberOfLines=0;//可多行显示
        self.eesTitleLabel.lineBreakMode=NSLineBreakByWordWrapping;//换行
        self.eesTitleLabel.textAlignment=NSTextAlignmentCenter;//居中
        [self.contentView addSubview:self.eesTitleLabel];
        
        //播放量
        self.eesPlayAmountLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-30, self.bounds.size.width/5*4, 30)];
        self.eesPlayAmountLabel.font=[UIFont systemFontOfSize:12];//设置字体大小
        [self.contentView addSubview:self.eesPlayAmountLabel];
        
        //收藏
        self.scollectButton=[[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width/5*4, self.bounds.size.height-30, self.bounds.size.width/5, 30)];
        [self.scollectButton setImage:[UIImage imageNamed:@"navCollect"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.scollectButton];
        
    }
    return self;
}


/*set重写*/
-(void)setSdm:(SpecialDetailModel *)sdm
{
    self.eesImageView.image=[UIImage imageNamed:sdm.eeImageName];
    self.eesTitleLabel.text=sdm.eeTitle;
    self.eesPlayAmountLabel.text=sdm.eePlayAmount;
}

@end
