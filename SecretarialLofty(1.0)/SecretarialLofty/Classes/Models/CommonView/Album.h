//
//  Album.h
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/10.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Album : NSObject

@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, copy) NSString *categoryName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *coverOrigin;
@property (nonatomic, copy) NSString *coverSmall;
@property (nonatomic, copy) NSString *coverLarge;
@property (nonatomic, copy) NSString *coverWebLarge;
@property (nonatomic, assign) NSInteger createdAt;
@property (nonatomic, assign) NSInteger updatedAt;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, assign) BOOL isVerified;
@property (nonatomic, copy) NSString *avatarPath;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *introRich;
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, assign) NSInteger tracks;
@property (nonatomic, assign) NSInteger shares;
@property (nonatomic, assign) BOOL hasNew;
@property (nonatomic, assign) BOOL isFavorite;
@property (nonatomic, assign) NSInteger playTimes;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger serializeStatus;
@property (nonatomic, assign) NSInteger zoneId;

@end
