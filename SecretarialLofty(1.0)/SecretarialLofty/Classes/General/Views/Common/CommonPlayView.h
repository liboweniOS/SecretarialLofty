//
//  CommonPlayView.h
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCProgressBarView;
@interface CommonPlayView : UIView

@property (nonatomic, copy) NSString *rateLabelOneValue;
@property (nonatomic, assign) NSInteger navPlayerValue;
@property (nonatomic, retain) UIButton *leftButton;
@property (nonatomic, copy) NSString *coverLarge;
@property (nonatomic, copy) NSString *briefTextValue;
// 上一曲
@property (nonatomic, retain) UIButton *upButton;
// 下一曲
@property (nonatomic, retain) UIButton *nextButton;

// 播放器进度条
@property (nonatomic, retain) MCProgressBarView *progressView;
// 播放器播放暂停按钮
@property (nonatomic, retain) UIButton *playOrPause;

#pragma mark - 当前时间label显示
- (void)setStartTimer:(NSString *)timerValue;

#pragma mark - 设置作者图片
- (void)setAuthorImageURL:(NSString *)authorImageURL;

#pragma mark - 设置作者
- (void)setAuthorLabelValue:(NSString *)authorLabelValue;

@end
