//
//  CCommonHeaderView.m
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/21.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "CCommonHeaderView.h"
#import "Info.h"
#import "UIImageView+WebCache.h"

@implementation CCommonHeaderView

#pragma mark - 自定义初始化方法
- (instancetype)initWithFrame:(CGRect)frame
                     andInfo:(Info *)inffo
{
    if (self = [super initWithFrame:frame]) {
        
        [self addAllViewsWithInfo:inffo];
    }
    return self;
}


#pragma mark - 自定义方法
#pragma mark addAllViews
- (void)addAllViewsWithInfo:(Info *)inffo
{
    // 设置头图片
    UIImageView *coverLargeView = [UIImageView new];
    [coverLargeView sd_setImageWithURL:[NSURL URLWithString:inffo.ccoverPathBig]];
    
    self.backgroundView = coverLargeView;
    self.backgroundView.alpha = 0.5;
    
    // 隔层
    UIView *view = [[UIView alloc] initWithFrame:self.frame];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.8;
    view.clipsToBounds = YES;
    [self addSubview:view];
    
    UIImageView *coverSmallView = [UIImageView new];
    [coverSmallView sd_setImageWithURL:[NSURL URLWithString:inffo.ccoverPathBig]];
    self.titleImageView = coverSmallView;
    _titleImageView.frame = CGRectMake(20, 20, 100, 100);
    // 设置圆角
    _titleImageView.layer.cornerRadius = 10;
    _titleImageView.clipsToBounds = YES;
    // 设置边框
    _titleImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _titleImageView.layer.borderWidth = 2;
    _titleImageView.layer.masksToBounds = YES;
    
    // 设置标题
    self.titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleImageView.frame.size.width + _titleImageView.frame.origin.x + 10, _titleImageView.frame.origin.y, 200, 35)];
    _titlelabel.numberOfLines = 0;
    _titlelabel.lineBreakMode = NSLineBreakByWordWrapping;
    _titlelabel.font = [UIFont boldSystemFontOfSize:20.0f];
    
    _titlelabel.text = inffo.cctitle;
    
    _titlelabel.textColor = [UIColor whiteColor];
    CGSize size = [_titlelabel sizeThatFits:CGSizeMake(_titlelabel.frame.size.width, MAXFLOAT)];
    _titlelabel.frame = CGRectMake(_titlelabel.frame.origin.x, _titlelabel.frame.origin.y, _titlelabel.frame.size.width, size.height);
    
    // 简介
    // 左侧图标的设置
    CGRect rect = CGRectMake(kScreenSize.width / 2 - 50, _titleImageView.frame.size.height + _titleImageView.frame.origin.y + 10, 40, 20);
    UIImageView *leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right.png"]];
    leftImageView.frame = rect;
    
    // 简介文字的位置设定
    UILabel *brief = [[UILabel alloc] initWithFrame:CGRectMake(rect.size.width + rect.origin.x, rect.origin.y, 30, 20)];
    brief.numberOfLines = 0;
    brief.lineBreakMode = NSLineBreakByWordWrapping;
    brief.font = [UIFont boldSystemFontOfSize:15.0f];
    brief.text = @"简介";
    brief.textColor = [UIColor whiteColor];
    
    // 右侧图标的设置
    UIImageView *rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"left.png"]];
    rightImageView.frame = CGRectMake(brief.frame.size.width + brief.frame.origin.x, brief.frame.origin.y, 40, 20);
    
    // 简介的内容
    self.briefTextView = [[UITextView alloc] initWithFrame:CGRectMake(_titleImageView.frame.origin.x, rightImageView.frame.origin.y + rightImageView.frame.size.height + 10, self.frame.size.width - _titleImageView.frame.origin.x - 10, 100)];
    
    _briefTextView.text = inffo.ccintro;
    _briefTextView.textColor = [UIColor lightGrayColor];
    _briefTextView.font = [UIFont boldSystemFontOfSize:12.0f];
    _briefTextView.scrollEnabled = NO;
    _briefTextView.backgroundColor = [UIColor clearColor];
    [_briefTextView setEditable:NO];
    
    // 作者
 self.authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(_briefTextView.frame.origin.x + _briefTextView.frame.size.width - 150, CGRectGetMaxY(_briefTextView.frame) - 10, 120, 50)];    _authorLabel.text = inffo.cctitle;
    _authorLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    _authorLabel.numberOfLines = 0;
    _authorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _authorLabel.textColor = [UIColor whiteColor];
    _authorLabel.textAlignment = NSTextAlignmentLeft;
    
    // 作者图片
    UIImageView *authorImageView = [UIImageView new];
    
    [authorImageView sd_setImageWithURL:[NSURL URLWithString:inffo.ccoverPathBig]];
    
    authorImageView.frame = CGRectMake(_authorLabel.frame.origin.x - 40, _authorLabel.frame.origin.y + 5, 30, 30);
    authorImageView.layer.cornerRadius = authorImageView.frame.size.width / 2;
    authorImageView.clipsToBounds = YES;
    
    [view addSubview:_titleImageView];
    [view addSubview:_titlelabel];
    [view addSubview:leftImageView];
    [view addSubview:brief];
    [view addSubview:rightImageView];
    [view addSubview:_briefTextView];
    [view addSubview:authorImageView];
    [view addSubview:_authorLabel];
}



@end
