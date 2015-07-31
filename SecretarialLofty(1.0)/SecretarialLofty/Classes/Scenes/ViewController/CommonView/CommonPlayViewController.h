//
//  CommonPlayViewController.h
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/11.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "List.h"
//@class List;
@class Track;

@interface CommonPlayViewController : UIViewController<UIPageViewControllerDelegate>

@property (nonatomic, retain) Track *trackObj;
@property (nonatomic, retain) List *listObj;
@property (nonatomic, copy) NSString *briefTextValue;


@property (nonatomic) NSInteger panduan;

- (void)playNext;

- (void)playPre;

// 进入界面的cell的下标
@property (nonatomic, assign) NSInteger tag;
// 当前播放的cell的下标
@property (nonatomic, assign) NSInteger playTag;
// 播放状态


@end
