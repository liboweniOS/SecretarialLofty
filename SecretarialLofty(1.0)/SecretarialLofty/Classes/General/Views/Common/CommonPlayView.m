//
//  CommonPlayView.m
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "CommonPlayView.h"
#import "MarqueeLabel.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

@interface CommonPlayView ()

@property (nonatomic, retain) MarqueeLabel *rateLabelOne;
@property (nonatomic, retain) UILabel *navPlayerValueLabel;
@property (nonatomic, retain) UILabel *startLabel;
@property (nonatomic, retain) UILabel *endLabel;
@property (nonatomic, retain) UITextView *briefTextView;
// 作者图片
@property (nonatomic, retain) UIImageView *authorImageView;
// 作者Label
@property (nonatomic, retain) UILabel *authorLabel;

@end

@implementation CommonPlayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}

#pragma mark - 自定义方法
#pragma mark addAllViews
- (void)addAllViews
{
    
    // 隔层
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(kScreenOrigin.x, 20, kScreenSize.width, kScreenSize.height)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.8;
    view.clipsToBounds = YES;
    [self addSubview:view];
    
    // 左侧返回按钮相关属性设置
    self.leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_leftButton setBackgroundImage:[UIImage imageNamed:@"left.png"] forState:UIControlStateNormal];
    _leftButton.frame = CGRectMake(10, 40, 40, 20);
    [self addSubview:_leftButton];
    
    // 标题相关属性设置
    self.rateLabelOne = [[MarqueeLabel alloc] initWithFrame:CGRectMake(_leftButton.frame.origin.x + _leftButton.frame.size.width + 5, _leftButton.frame.origin.y, 230, 20) rate:20.0f andFadeLength:10.0f];
    _rateLabelOne.numberOfLines = 1;
    _rateLabelOne.opaque = NO;
    _rateLabelOne.enabled = YES;
    _rateLabelOne.shadowOffset = CGSizeMake(0.0, -1.0);
    _rateLabelOne.textAlignment = NSTextAlignmentCenter;
    _rateLabelOne.textColor = [UIColor whiteColor];
    _rateLabelOne.backgroundColor = [UIColor clearColor];
    _rateLabelOne.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.000];

    [self addSubview:_rateLabelOne];
    
    
    UIImageView *navPlayerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navPlayer.png"]];
    navPlayerImageView.frame = CGRectMake(_rateLabelOne.frame.origin.x + _rateLabelOne.frame.size.width + 10, _rateLabelOne.frame.origin.y, 20, 20);
    [self addSubview:navPlayerImageView];

    
    // 分隔符相关属性设置
    UIImageView *segImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chaptertitle.png"]];
    segImageView.frame = CGRectMake(60, _leftButton.frame.origin.y + 50, self.frame.size.width - 120, 10);
    [self addSubview:segImageView];
    
    // 简介
    // 简介文字的位置设定
    UILabel *brief = [[UILabel alloc] initWithFrame:CGRectMake(kScreenSize.width / 2 - 15,
    segImageView.frame.size.height + segImageView.frame.origin.y + 10, 40, 20)];
    brief.numberOfLines = 0;
    brief.lineBreakMode = NSLineBreakByWordWrapping;
    brief.font = [UIFont boldSystemFontOfSize:15.0f];
    brief.text = @"简介";
    brief.textColor = [UIColor whiteColor];
    [self addSubview:brief];
    
    // 简介的内容
    self.briefTextView = [[UITextView alloc] initWithFrame:CGRectMake(segImageView.frame.origin.x, CGRectGetMaxY(brief.frame) + 10, segImageView.frame.size.width, 180)];
    _briefTextView.textColor = [UIColor lightGrayColor];
    _briefTextView.font = [UIFont boldSystemFontOfSize:15.0f];
    _briefTextView.scrollEnabled = NO;
    _briefTextView.backgroundColor = [UIColor clearColor];
    [_briefTextView setEditable:NO];
    [self addSubview:_briefTextView];
    
    // 作者图片相关属性设置
    self.authorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenNewSize.size.width / 1.7, kScreenNewSize.size.height / 1.5, 30, 30)];
    _authorImageView.layer.cornerRadius = _authorImageView.frame.size.width / 2;
    _authorImageView.clipsToBounds = YES;
    [self addSubview:_authorImageView];
    
    // 作者文字相关属性设置
    self.authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_authorImageView.frame) + 10, CGRectGetMinY(_authorImageView.frame), kScreenNewSize.size.width / 10, 30)];
    _authorLabel.numberOfLines = 0;
    _authorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _authorLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    _authorLabel.textAlignment=NSTextAlignmentCenter;
    _authorLabel.textColor = [UIColor whiteColor];
    [self addSubview:_authorLabel];
    
    // 播放按钮
//    UIImageView *navPlayerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navPlayer.png"]];
//    navPlayerImageView.frame = CGRectMake(_rateLabelOne.frame.origin.x + _rateLabelOne.frame.size.width + 10, _rateLabelOne.frame.origin.y, 20, 20);
//    [self addSubview:navPlayerImageView];
    
    // 播放时长相关属性设置
    CGFloat navPlayerWidth = navPlayerImageView.frame.origin.x + navPlayerImageView.frame.size.width + 5;
    self.navPlayerValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(navPlayerImageView.frame.origin.x + navPlayerImageView.frame.size.width + 5, navPlayerImageView.frame.origin.y,
        self.frame.size.width - navPlayerWidth, navPlayerImageView.frame.size.height)];
    _navPlayerValueLabel.textAlignment = NSTextAlignmentLeft;
    _navPlayerValueLabel.textColor = [UIColor lightGrayColor];
    _navPlayerValueLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.000];
    [self addSubview:_navPlayerValueLabel];
    
    // 进度条相关属性设置
    UIImage * backgroundImage = [[UIImage imageNamed:@"progress-bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    UIImage * foregroundImage = [[UIImage imageNamed:@"progress-fg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    self.progressView = [[MCProgressBarView alloc] initWithFrame:CGRectMake(60, kScreenSize.height - 40, kScreenSize.width - 120, 20) backgroundImage:backgroundImage foregroundImage:foregroundImage];
    [self addSubview:_progressView];
    
    // 开始时间相关属性设置
    self.startLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, _progressView.frame.origin.y, 45, _progressView.frame.size.height)];
    _startLabel.textAlignment = NSTextAlignmentRight;
    _startLabel.textColor = [UIColor lightGrayColor];
    _startLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.000];
    _startLabel.text = @"00:00";
    [self addSubview:_startLabel];
    
    // 结束时间
    self.endLabel = [[UILabel alloc] initWithFrame:CGRectMake(_progressView.frame.origin.x + _progressView.frame.size.width + 5, _progressView.frame.origin.y, 45, _progressView.frame.size.height)];
    _endLabel.textAlignment = NSTextAlignmentRight;
    _endLabel.textColor = [UIColor lightGrayColor];
    _endLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.000];
    [self addSubview:_endLabel];
    
    // 播放或停止按钮相关设置
    self.playOrPause = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _playOrPause.frame = CGRectMake(kScreenSize.width / 2 - 30, _endLabel.frame.origin.y - 80, 60, 60);
    _playOrPause.layer.cornerRadius = _playOrPause.frame.size.width / 2;
    _playOrPause.clipsToBounds = YES;
    [_playOrPause setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    [self addSubview:_playOrPause];
    
    // 上一曲按钮
    self.upButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _upButton.frame = CGRectMake(_playOrPause.frame.origin.x - 120, _endLabel.frame.origin.y - 80, 60, 60);
    _upButton.layer.cornerRadius = _playOrPause.frame.size.width / 2;
    _upButton.clipsToBounds = YES;
    [_upButton setBackgroundImage:[UIImage imageNamed:@"up.png"] forState:UIControlStateNormal];
    [self addSubview:_upButton];
    
    // 下一曲按钮
    self.nextButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _nextButton.frame = CGRectMake(_playOrPause.frame.origin.x + _playOrPause.frame.size.width + 60, _endLabel.frame.origin.y - 80, 60, 60);
    _nextButton.layer.cornerRadius = _playOrPause.frame.size.width / 2;
    _nextButton.clipsToBounds = YES;
    [_nextButton setBackgroundImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
    [self addSubview:_nextButton];
}

#pragma mark - 重写
- (void)setNavPlayerValue:(NSInteger)navPlayerValue
{
    _navPlayerValue = navPlayerValue;
    // 进度条赋值
    _progressView.progress = 0.0f;
    // 结束时间label赋值
    _endLabel.text = [NSString timeFormatted:navPlayerValue];
    // 赋值
    _navPlayerValueLabel.text = [NSString timeFormatted:navPlayerValue];
}

- (void)setRateLabelOneValue:(NSString *)rateLabelOneValue
{
    if (_rateLabelOneValue != rateLabelOneValue) {
        _rateLabelOneValue = nil;
        _rateLabelOneValue = [rateLabelOneValue copy];
        
        // 赋值
        _rateLabelOne.text = rateLabelOneValue;
    }
}

- (void)setCoverLarge:(NSString *)coverLarge
{
    // 设置头图片
    UIImageView *coverLargeView = [UIImageView new];
    [coverLargeView sd_setImageWithURL:[NSURL URLWithString:coverLarge]];
    
    coverLargeView.alpha = 0.5;
    coverLargeView.frame = CGRectMake(kScreenOrigin.x, 20, kScreenSize.width, kScreenSize.height);
    [self insertSubview:coverLargeView atIndex:0];
}

- (void)setBriefTextValue:(NSString *)briefTextValue
{
    if (_briefTextValue != briefTextValue) {
        _briefTextValue = nil;
        _briefTextValue = [briefTextValue copy];
        
        _briefTextView.text = briefTextValue;
    }
}

#pragma mark - 当前时间label显示
- (void)setStartTimer:(NSString *)timerValue
{
    // 赋值
    _startLabel.text = timerValue;
}

#pragma mark - 设置作者图片
- (void)setAuthorImageURL:(NSString *)authorImageURL
{
    // 赋值
    [_authorImageView sd_setImageWithURL:[NSURL URLWithString:authorImageURL]];
}

#pragma mark - 设置作者
- (void)setAuthorLabelValue:(NSString *)authorLabelValue
{
    // 赋值
    _authorLabel.text = authorLabelValue;
}

@end
