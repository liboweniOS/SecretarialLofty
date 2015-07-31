//
//  Track.h
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/11.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayListModel.h"

@interface Track : PlayListModel

@property (nonatomic, assign) NSInteger trackId;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, copy) NSString *playUrl64;
@property (nonatomic, copy) NSString *playUrl32;
@property (nonatomic, copy) NSString *downloadUrl;
@property (nonatomic, copy) NSString *playPathAacv164;
@property (nonatomic, copy) NSString *playPathAacv224;
@property (nonatomic, copy) NSString *downloadAacUrl;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) NSInteger processState;
@property (nonatomic, assign) NSInteger createdAt;
@property (nonatomic, copy) NSString *coverSmall;
@property (nonatomic, copy) NSString *coverLarge;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *smallLogo;
@property (nonatomic, assign) NSInteger userSource;
@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, copy) NSString *albumTitle;
@property (nonatomic, copy) NSString *albumImage;
@property (nonatomic, assign) NSInteger orderNum;
@property (nonatomic, assign) NSInteger opType;
@property (nonatomic, assign) NSInteger refUid;
@property (nonatomic, copy) NSString *refNickname;
@property (nonatomic, copy) NSString *refSmallLogo;
@property (nonatomic, assign) BOOL isPublic;
@property (nonatomic, assign) NSInteger likes;
@property (nonatomic, assign) NSInteger playtimes;
@property (nonatomic, assign) NSInteger comments;
@property (nonatomic, assign) NSInteger shares;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger downloadSize;
@property (nonatomic, assign) NSInteger downloadAacSize;
@property (nonatomic, copy) NSString* commentContent;

// tag标示
@property (nonatomic, assign) NSInteger Tag;

@end
