//
//  SpecialDetailTableViewCell.m
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/10.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "SpecialDetailTableViewCell.h"

@implementation SpecialDetailTableViewCell

@synthesize sdm=_sdm;//重写属性

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self layoutCell];
    }
    return self;
}


/*cell布局*/
-(void)layoutCell
{
    //cell的图片
    self.eeImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 110, 110)];
    //self.eeImageView.backgroundColor=[UIColor orangeColor];
    //边框
    self.eeImageView.layer.borderColor=[UIColor whiteColor].CGColor;
    self.eeImageView.layer.borderWidth=4;
    self.eeImageView.layer.cornerRadius=20;//圆角
    self.eeImageView.layer.masksToBounds=YES;//切掉边框之外的
    [self.contentView addSubview:self.eeImageView];
    
    //cell的标题
    self.eeTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(115, 0, [UIScreen mainScreen].bounds.size.width-112, 55)];
    [self.eeTitleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];//加粗
    self.eeTitleLabel.numberOfLines=0;//可多行显示
    self.eeTitleLabel.lineBreakMode=NSLineBreakByWordWrapping;//换行
    [self.contentView addSubview:self.eeTitleLabel];
    
    //cell的点击量
    self.eePlayAmountLabel=[[UILabel alloc]initWithFrame:CGRectMake(115, 75, 140, 35)];
    self.eePlayAmountLabel.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.eePlayAmountLabel];
    
    //收藏
    self.collectButton=[[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-35, 80, 30, 30)];
    [self.collectButton setImage:[UIImage imageNamed:@"navCollect"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.collectButton];
    
    
    
}


/*set重写*/
-(void)setSdm:(SpecialDetailModel *)sdm
{
    self.eeImageView.image=[UIImage imageNamed:sdm.eeImageName];
    self.eeTitleLabel.text=sdm.eeTitle;
    self.eePlayAmountLabel.text=sdm.eePlayAmount;
}














- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
