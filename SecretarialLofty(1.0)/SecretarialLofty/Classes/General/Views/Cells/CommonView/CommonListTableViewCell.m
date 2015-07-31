//
//  CommonListTableViewCell.m
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/11.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "CommonListTableViewCell.h"
#import "UIButton+WebCache.h"

@interface CommonListTableViewCell ()

@property (nonatomic, retain) UILabel *bTitleLabel;
@property (nonatomic, retain) UILabel *bTimerLabel;
@property (nonatomic, retain) UILabel *bAuthorLabel;

@end

@implementation CommonListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addAllViews];
    }
    return self;
}

#pragma mark - 自定义方法
#pragma mark addAllViews
- (void)addAllViews
{
    // 按钮初始化及相关设置
    self.bButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _bButton.frame = CGRectMake(10, 10, 60, 60);
    _bButton.layer.cornerRadius = _bButton.frame.size.width / 2;
    _bButton.clipsToBounds = YES;
    
    // 标题初始化及相关设置
//    self.bTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_bButton.frame.origin.x + _bButton.frame.size.width + 5, _bButton.frame.origin.y, 270, 60)];
     self.bTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxY(_bButton.frame) + 5, _bButton.frame.origin.y, kScreenNewSize.size.width - CGRectGetMaxY(_bButton.frame) - 8, 60)];
    
    // 自适应
    _bTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _bTitleLabel.numberOfLines = 0;
    _bTitleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    
    // 播放时间图片初始化及相关设置
    UIImageView *timerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellTimer.png"]];
    timerImageView.frame = CGRectMake(_bTitleLabel.frame.origin.x,
                                      _bButton.frame.origin.y + _bButton.frame.size.height + 5,
                                      20,
                                      20);
    // 播放时间值的设定
    self.bTimerLabel = [[UILabel alloc] initWithFrame:CGRectMake(timerImageView.frame.origin.x + timerImageView.frame.size.width + 5, timerImageView.frame.origin.y, 60, 20)];
    _bTimerLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _bTimerLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    _bTimerLabel.textColor = [UIColor lightGrayColor];
    
    // 作者图片初始化及相关设置
    UIImageView *authorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellAuthor.png"]];
    authorImageView.frame = CGRectMake(_bTimerLabel.frame.origin.x + _bTimerLabel.frame.size.width + 5, _bTimerLabel.frame.origin.y, 20, 20);
    
    // 作者信息设定
//    self.bAuthorLabel = [[UILabel alloc] initWithFrame:CGRectMake(authorImageView.frame.origin.x + authorImageView.frame.size.width + 5, authorImageView.frame.origin.y, 150, 20)];

    self.bAuthorLabel = [[UILabel alloc] initWithFrame:CGRectMake(authorImageView.frame.origin.x + authorImageView.frame.size.width + 5, authorImageView.frame.origin.y, 150, 20)];

    _bAuthorLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _bAuthorLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    _bAuthorLabel.textColor = [UIColor lightGrayColor];
    
    // 跳转按钮初始化及相关设置
    self.skipButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _skipButton.frame = CGRectMake(_bTitleLabel.frame.origin.x + _bTitleLabel.frame.size.width + 5, self.frame.size.height / 2 + 11, 11, 22);
    [_skipButton setBackgroundImage:[UIImage imageNamed:@"icon_rightArrow_selected.png"] forState:UIControlStateNormal];
    
    [self addSubview:_bButton];
    [self addSubview:_bTitleLabel];
    [self addSubview:timerImageView];
    [self addSubview:_bTimerLabel];
    [self addSubview:authorImageView];
    [self addSubview:_bAuthorLabel];
    [self addSubview:_skipButton];
}

#pragma mark - 重写
- (void)setImageURL:(NSString *)imageURL
{
    if (_imageURL != imageURL) {
        _imageURL = nil;
        _imageURL = [imageURL copy];
        
        [_bButton sd_setBackgroundImageWithURL:[NSURL URLWithString:imageURL] forState:UIControlStateNormal];
    }
}

- (void)setTitleValue:(NSString *)titleValue
{
    if (_titleValue != titleValue) {
        _titleValue = nil;
        _titleValue = [titleValue copy];
        
        _bTitleLabel.text = titleValue;
    }
}

- (void)setTimerCount:(NSInteger)timerCount
{
    _timerCount = timerCount;
    NSString *timerValue = [NSString timeFormatted:_timerCount];
    // 赋值
    _bTimerLabel.text = timerValue;
}

- (void)setAuthorName:(NSString *)authorName
{
    if (authorName != _authorName) {
        _authorName = nil;
        _authorName = [authorName copy];
        
        // 赋值
        _bAuthorLabel.text = authorName;
    }
}

@end