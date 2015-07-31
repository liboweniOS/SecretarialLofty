//
//  AVPlayerHelper.h
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/11.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol AVPlayerHelperDelegate <NSObject>

@optional
-(void)stopAnimation;

@end

@interface AVPlayerHelper : NSObject

@property (nonatomic, retain) AVPlayer *audioPlayer;

@property (nonatomic, copy) NSString *playerURL;
// 获取播放列表
@property (nonatomic, retain) NSArray *allDataArray;
// 获取播放button对象
@property (nonatomic, assign) NSInteger playerIndex;
// 获取title信息
@property (nonatomic, copy) NSString *briefTextValue;
//代理
@property (nonatomic, weak)id<AVPlayerHelperDelegate>delegate;

//  播放下一首执行的block
@property (nonatomic, copy) void (^sendPlayNextMsg)();
//  播放上一首执行的block
@property (nonatomic, copy) void (^sendPlayPretMsg)();

#pragma mark - 单例构造器
+ (AVPlayerHelper *)sharedAVPlayerHelper;

#pragma mark - 初始化audioPlayer对象
- (void) initAudioPlayerWithURL:(NSString *)urlStr;

#pragma mark - 播放
- (void)play;

#pragma mark - 暂停
- (void)pause;

#pragma mark - 停止
- (void)stop;

#pragma mark - 获取AVPlayer对象
- (AVPlayer *)getAVPlayer;

#pragma mark - 获取播放状态
- (BOOL)playerState;
@end