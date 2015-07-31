//
//  CommonPlayViewController.m
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/11.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "CommonPlayViewController.h"
#import "CommonPlayView.h"
#import "AMTumblrHud.h"
#import "AVPlayerHelper.h"

@interface CommonPlayViewController ()

@property (nonatomic, retain) CommonPlayView *rootView;
@property (nonatomic, retain) UIAlertView *alertView;
@property (nonatomic, retain) AMTumblrHud *amTumb;
@property (nonatomic, strong) NSTimer *timerMonitor;
@property (nonatomic, assign) BOOL flag;





@end

@implementation CommonPlayViewController

#pragma mark - 重写
#pragma mark 设置自定义视图
- (void)loadView
{
    self.rootView = [[CommonPlayView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self finishView];
    
    _flag = YES;
    
    [[AVPlayerHelper sharedAVPlayerHelper].audioPlayer addObserver:self forKeyPath:@"currentItem" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    
    // 加载数据
    [self loadData];
    
    // 返回按钮点击事件
    [_rootView.leftButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];

    // 设置播放按钮点击状态
    [self.rootView.playOrPause addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 下一曲播放按钮点击事件
    [self.rootView.nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    
    // 上一曲播放按钮点击事件
    [self.rootView.upButton addTarget:self action:@selector(upAction:) forControlEvents:UIControlEventTouchUpInside];
    
    __weak typeof(self) weakSelf = self;
    [AVPlayerHelper sharedAVPlayerHelper].sendPlayNextMsg = ^() {
        [weakSelf playNext];
    };
    
    [AVPlayerHelper sharedAVPlayerHelper].sendPlayPretMsg = ^() {
        [weakSelf playPre];
    };
    
    if ([AVPlayerHelper sharedAVPlayerHelper].playerState) {
        self.timerMonitor = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerMonitorAction:) userInfo:nil repeats:YES];
    }
    
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"currentItem"]){
        if (change[@"old"] && ![change[@"old"] isKindOfClass:[NSNull class]]) {
            if (self.timerMonitor) {
                [self.timerMonitor invalidate];
                self.timerMonitor = nil;
            }
        }
        if (!change[@"new"]) {
            return;
        }
        
        self.timerMonitor = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerMonitorAction:) userInfo:nil repeats:YES];
    }
}

- (void)timerMonitorAction:(NSTimer *)sender
{
    CMTime currentTime = [AVPlayerHelper sharedAVPlayerHelper].audioPlayer.currentTime;
    CMTime duration = [AVPlayerHelper sharedAVPlayerHelper].audioPlayer.currentItem.duration;
    // 设置当前进度条进度
    MCProgressBarView *progress = _rootView.progressView;
    CGFloat current = CMTimeGetSeconds(currentTime);
    CGFloat total = CMTimeGetSeconds(duration);
    [progress setProgress:(current/total)];
    // 设定当前播放时间
    [self.rootView setStartTimer:[NSString timeFormatted:current]];
}

#pragma mark - 上一曲播放按钮点击事件
- (void)upAction:(UIButton *)sender
{
    [self playPre];
}

#pragma mark - 下一曲播放按钮点击事件
- (void)nextAction
{
    [self playNext];
    
}



#pragma mark - 设置显示多长时间后消失
- (void)doTime
{
    [_alertView dismissWithClickedButtonIndex:0 animated:NO];
    _alertView = nil;
}

#pragma mark - 请求效果
- (void)finishView
{
    self.amTumb = [[AMTumblrHud alloc] initWithFrame:CGRectMake((CGFloat) ((self.view.frame.size.width - 55) * 0.5), (CGFloat) ((self.view.frame.size.height - 20) * 0.5), 55, 20)];
    self.amTumb.hudColor = [UIColor orangeColor];
    [self.view addSubview:self.amTumb];
    [self.amTumb showAnimated:NO];
}

#pragma mark - 加载数据
- (void)loadData
{
    CommonTableViewController *commonTable=[[CommonTableViewController alloc]init];
    if(commonTable.panduan==1){
        self.rootView.rateLabelOneValue = self.listObj.cctitle;
        self.rootView.navPlayerValue = [self.listObj.ccduration integerValue];
        self.rootView.coverLarge = self.listObj.ccoverLarge;
        self.rootView.briefTextValue = self.briefTextValue;
        // 设置作者图片
        [self.rootView setAuthorImageURL:self.listObj.ccoverSmall];
        // 设置作者
        [self.rootView setAuthorLabelValue:self.listObj.ccalbumTitle];
    }
    else{
    self.rootView.rateLabelOneValue = self.trackObj.title;
    self.rootView.navPlayerValue = self.trackObj.duration;
    self.rootView.coverLarge = self.trackObj.coverLarge;
    self.rootView.briefTextValue = self.briefTextValue;
    // 设置作者图片
    [self.rootView setAuthorImageURL:self.trackObj.albumImage];
    // 设置作者
    [self.rootView setAuthorLabelValue:self.trackObj.albumTitle];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    
    // 设置播放按钮状态
    [self setPlayOrPauseState:_rootView.playOrPause];
}

#pragma mark - 播放按钮点击事件
- (void)playAction:(UIButton *)sender
{
    
    if (_flag) {
        self.playTag = self.tag;
        [sender setBackgroundImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
        CABasicAnimation *basicAnimation = [[CABasicAnimation alloc] init];
        // 设置动画时间
        basicAnimation.duration = 4;
        // 设置动画重复
        basicAnimation.repeatCount = HUGE_VAL;
        // 设置动画的作用
        basicAnimation.keyPath = @"transform.rotation.z";
        // 设定旋转角度
        basicAnimation.fromValue = [NSNumber numberWithFloat:0.0]; // 起始角度
        basicAnimation.toValue = [NSNumber numberWithFloat:2 * M_PI]; // 终止角度
        
        [sender.layer addAnimation:basicAnimation forKey:[NSString stringWithFormat:@"play"]];
        // 播放音乐
        // 判断播放的音乐是否是当前音乐
        //CommonTableViewController *commonTable=[[CommonTableViewController alloc]init];
        if (self.panduan==1) {
            if (![[AVPlayerHelper sharedAVPlayerHelper] playerState] || ![[AVPlayerHelper sharedAVPlayerHelper].playerURL isEqualToString:self.listObj.ccplayPath64]) {
                // 创建播放新音乐对象
                [[AVPlayerHelper sharedAVPlayerHelper] initAudioPlayerWithURL:self.listObj.ccplayPath64];
            }
        }
        else if (![[AVPlayerHelper sharedAVPlayerHelper] playerState] || ![[AVPlayerHelper sharedAVPlayerHelper].playerURL isEqualToString:self.trackObj.playUrl64]) {
            // 创建播放新音乐对象
            [[AVPlayerHelper sharedAVPlayerHelper] initAudioPlayerWithURL:self.trackObj.playUrl64];
        }
        
        // 播放
        [[AVPlayerHelper sharedAVPlayerHelper] play];
        _flag = NO;
    } else {
        // 改变播放按钮图片
        self.playTag = -1;
        [sender setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        [sender.layer removeAnimationForKey:[NSString stringWithFormat:@"play"]];
        // 停止播放
        [[AVPlayerHelper sharedAVPlayerHelper] pause];
        _flag = YES;
    }
    
    [AVPlayerHelper sharedAVPlayerHelper].playerIndex = self.playTag;
}

#pragma mark - 设置播放按钮状态
- (void)setPlayOrPauseState:(UIButton *)sender
{
    // 判断播放地址是否相同
    if (([[AVPlayerHelper sharedAVPlayerHelper].playerURL isEqualToString:self.trackObj.playUrl64]
         && [[AVPlayerHelper sharedAVPlayerHelper] playerState])||([[AVPlayerHelper sharedAVPlayerHelper].playerURL isEqualToString:self.listObj.ccplayPath64]&& [[AVPlayerHelper sharedAVPlayerHelper] playerState])) {
        
        // 相同的场合，设置播放安装旋转状态
        [sender setBackgroundImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
        // 设置状态
        CABasicAnimation *basicAnimation = [[CABasicAnimation alloc] init];
        // 设置动画时间
        basicAnimation.duration = 4;
        // 设置动画重复
        basicAnimation.repeatCount = HUGE_VAL;
        // 设置动画的作用
        basicAnimation.keyPath = @"transform.rotation.z";
        // 设定旋转角度
        basicAnimation.fromValue = [NSNumber numberWithFloat:0.0]; // 起始角度
        basicAnimation.toValue = [NSNumber numberWithFloat:2 * M_PI]; // 终止角度
        // 执行动画
        [sender.layer addAnimation:basicAnimation forKey:[NSString stringWithFormat:@"play"]];

        _flag = NO;
        
        
        
        
      }
}


#pragma mark 播放下一首
-(void)playNext
{
    if (self.tag == [AVPlayerHelper sharedAVPlayerHelper].allDataArray.count - 1) {
        self.tag = 0;
    } else {
        self.tag ++;
    }
    [self updatePlayerSettingWithIsNext:YES];
}

- (void)playPre
{
    
    // 新哥
    if (self.tag == 0) {
        self.tag = [AVPlayerHelper sharedAVPlayerHelper].allDataArray.count - 1;
    } else {
        self.tag --;
    }
    // 更新播放器
    [self updatePlayerSettingWithIsNext:NO];
}


//更新播放器设置
- (void)updatePlayerSettingWithIsNext:(BOOL)isNext
{
    
    self.playTag = self.tag;
    [AVPlayerHelper sharedAVPlayerHelper].playerIndex = self.playTag;
    // 更新上一个界面
    
    // 获取下一首曲目的model
//    CommonTableViewController *commonTable=[[CommonTableViewController alloc]init];
    if (self.panduan==1) {
        self.listObj=[AVPlayerHelper sharedAVPlayerHelper].allDataArray[_tag];
    }
    else{
    self.trackObj = [AVPlayerHelper sharedAVPlayerHelper].allDataArray[_tag];
    }
    // 重新加载页面
    [self finishView];
    [self loadData];
    [self reloadInputViews];
    
    // 创建播放新音乐对象
    if (self.panduan==1) {
        [[AVPlayerHelper sharedAVPlayerHelper] initAudioPlayerWithURL:self.listObj.ccplayPath64];
    }
    else {
    [[AVPlayerHelper sharedAVPlayerHelper] initAudioPlayerWithURL:self.trackObj.playUrl64];
    }
//    [self addProgressObserver];
    // 播放
    [[AVPlayerHelper sharedAVPlayerHelper] play];
    // 当前播放的状态
    [self playState:_rootView.playOrPause];
}

#pragma mark - 返回按钮点击事件
- (void)backAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 设置当前播放状态及进度条初始化
- (void)playState:(UIButton *)sender
{
    // 相同的场合，设置播放安装旋转状态
    [sender setBackgroundImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
    // 设置状态
    CABasicAnimation *basicAnimation = [[CABasicAnimation alloc] init];
    // 设置动画时间
    basicAnimation.duration = 4;
    // 设置动画重复
    basicAnimation.repeatCount = HUGE_VAL;
    // 设置动画的作用
    basicAnimation.keyPath = @"transform.rotation.z";
    // 设定旋转角度
    basicAnimation.fromValue = [NSNumber numberWithFloat:0.0]; // 起始角度
    basicAnimation.toValue = [NSNumber numberWithFloat:2 * M_PI]; // 终止角度
    // 执行动画
    [sender.layer addAnimation:basicAnimation forKey:[NSString stringWithFormat:@"play"]];
    
    _flag = NO;
}

@end