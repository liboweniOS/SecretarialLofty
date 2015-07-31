//
//  AVPlayerHelper.m
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/11.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "AVPlayerHelper.h"


@interface AVPlayerHelper () <AVAudioPlayerDelegate>
{
    BOOL isPlay;
}
@property (nonatomic, retain) NSTimer *timer;


@end

@implementation AVPlayerHelper

#pragma mark - 单例构造器
+ (AVPlayerHelper *)sharedAVPlayerHelper
{
    static AVPlayerHelper *sharedAVPlayerHelper = nil;
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        
        sharedAVPlayerHelper = [[AVPlayerHelper alloc] init];
        sharedAVPlayerHelper.audioPlayer = [AVPlayer new];
    });
    
    return sharedAVPlayerHelper;
}

#pragma mark - 初始化audioPlayer对象
- (void) initAudioPlayerWithURL:(NSString *)urlStr
{
    // 保存播放URL
    self.playerURL = urlStr;
    NSString *urlStr1 = [NSString stringWithFormat:urlStr,0];
    urlStr1 = [urlStr1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr1];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    
    
    if (self.audioPlayer.currentItem) {
        [self.audioPlayer.currentItem removeObserver:self forKeyPath:@"currentTime"];
    }
    [self.audioPlayer replaceCurrentItemWithPlayerItem:playerItem];
    [self.audioPlayer.currentItem addObserver:self forKeyPath:@"currentTime" options:NSKeyValueObservingOptionNew context:nil];
    
    // 初始化音量大小
    _audioPlayer.volume = 1;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"currentTime"]) {
        CGFloat current = CMTimeGetSeconds([change[@"mew"] CMTimeValue]);
        CGFloat total = CMTimeGetSeconds([self.audioPlayer.currentItem duration]);
        if ((int)current == (int)total) {
            NSLog(@"播放结束,NEXT");
            if (_sendPlayNextMsg) {
                _sendPlayNextMsg();
            }
        }
        
    }
}

#pragma mark - 播放
- (void)play
{
    isPlay = YES;
//    [_audioPlayer setAllowsExternalPlayback:YES];
    [_audioPlayer play];
}

#pragma mark - 暂停
- (void)pause
{
    isPlay = NO;
    [_audioPlayer pause];
}

#pragma mark - 停止
- (void)stop
{
    isPlay = NO;
//    _audioPlayer.currentTime = 0;
//    [_audioPlayer stop];
}

#pragma mark - 代理方法
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [_timer invalidate];
    [self.delegate stopAnimation];
    
}

#pragma mark - 获取AVPlayer对象
- (AVPlayer *)getAVPlayer
{
    return _audioPlayer;
}

#pragma mark - 获取播放状态
- (BOOL)playerState
{
    //AVPlayerItem *playerItem = _audioPlayer.currentItem;
    if (isPlay)
    {
        return YES;
    }
    return NO;
}

@end