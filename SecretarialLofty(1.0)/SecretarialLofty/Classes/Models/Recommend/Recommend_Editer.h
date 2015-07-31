//
//  Recommend_Editer.h
//  SecretarialLofty
//
//  Created by SecretarialLofty on 15/7/9.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recommend_Editer : NSObject

@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, copy) NSString *coverLarge;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, assign) NSInteger tracks;
@property (nonatomic, assign) NSInteger playsCounts;
@property (nonatomic, assign) NSInteger isFinished;
@property (nonatomic, assign) NSInteger trackId;
@property (nonatomic, copy) NSString *trackTitle;
// 跳转用Id
@property (nonatomic, assign) NSInteger categoryId;

@end