//
//  CommonHeaderView.m
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/10.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "CommonHeaderView.h"
#import "Album.h"
#import "UIImageView+WebCache.h"

@implementation CommonHeaderView

#pragma mark - 自定义初始化方法
- (instancetype)initWithFrame:(CGRect)frame
                     andAlbum:(Album *)album
{
    if (self = [super initWithFrame:frame]) {

        [self addAllViewsWithAlbum:album];
    }
    return self;
}

#pragma mark - 自定义方法
#pragma mark addAllViews
- (void)addAllViewsWithAlbum:(Album *)album
{
    // 设置头图片
    UIImageView *coverLargeView = [UIImageView new];
    [coverLargeView sd_setImageWithURL:[NSURL URLWithString:album.coverLarge]];

    self.backgroundView = coverLargeView;
    self.backgroundView.alpha = 0.5;
    
    // 隔层
    UIView *view = [[UIView alloc] initWithFrame:self.frame];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.8;
    view.clipsToBounds = YES;
    [self addSubview:view];

    UIImageView *coverSmallView = [UIImageView new];
    [coverSmallView sd_setImageWithURL:[NSURL URLWithString:album.coverSmall]];
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
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(_titleImageView.frame.size.width + _titleImageView.frame.origin.x + 10, _titleImageView.frame.origin.y, 180, 35)];
    _title.numberOfLines = 0;
    _title.lineBreakMode = NSLineBreakByWordWrapping;
    _title.font = [UIFont boldSystemFontOfSize:20.0f];
    _title.text = album.title;
    _title.textColor = [UIColor whiteColor];
    CGSize size = [_title sizeThatFits:CGSizeMake(_title.frame.size.width, MAXFLOAT)];
    _title.frame = CGRectMake(_title.frame.origin.x, _title.frame.origin.y, _title.frame.size.width, size.height);
    
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
    _briefTextView.text = album.intro;
    _briefTextView.textColor = [UIColor lightGrayColor];
    _briefTextView.font = [UIFont boldSystemFontOfSize:13.0f];
    _briefTextView.scrollEnabled = NO;
    _briefTextView.backgroundColor = [UIColor clearColor];
    [_briefTextView setEditable:NO];

    // 作者
//    self.authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(_briefTextView.frame.origin.x + _briefTextView.frame.size.width - 150, _briefTextView.frame.origin.y + _briefTextView.frame.size.height, 120, 20)];
    self.authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(_briefTextView.frame.origin.x + _briefTextView.frame.size.width - 150, CGRectGetMaxY(_briefTextView.frame) - 5, 120, 30)];
    _authorLabel.text = album.nickname;
    _authorLabel.numberOfLines = 0;
    _authorLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    _authorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _authorLabel.textColor = [UIColor whiteColor];
    _authorLabel.textAlignment = NSTextAlignmentLeft;
    
    // 作者图片
    UIImageView *authorImageView = [UIImageView new];
    [authorImageView sd_setImageWithURL:[NSURL URLWithString:album.avatarPath]];
    authorImageView.frame = CGRectMake(_authorLabel.frame.origin.x - 40, _authorLabel.frame.origin.y - 2, 30, 30);
    authorImageView.layer.cornerRadius = authorImageView.frame.size.width / 2;
    authorImageView.clipsToBounds = YES;
    
    [view addSubview:_titleImageView];
    [view addSubview:_title];
    [view addSubview:leftImageView];
    [view addSubview:brief];
    [view addSubview:rightImageView];
    [view addSubview:_briefTextView];
    [view addSubview:authorImageView];
    [view addSubview:_authorLabel];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
