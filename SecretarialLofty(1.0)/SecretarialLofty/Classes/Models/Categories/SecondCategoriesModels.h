//
//  SecondCategoriesModels.h
//  SecretarialLofty
//
//  Created by 康辰 on 15/7/10.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SecondCategoriesModels : NSObject

@property (nonatomic, copy) NSString *albumCoverUrl290;
@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, copy) NSString *coverMiddle;
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, assign) NSInteger isFinished;
@property (nonatomic, assign) NSInteger lastUptrackAt;
@property (nonatomic, assign) NSInteger lastUptrackId;
@property (nonatomic, copy) NSString *lastUptrackTitle;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, assign) NSInteger playsCounts;
@property (nonatomic, assign) NSInteger serialState;
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, copy) NSString *Title;
@property (nonatomic, assign) NSInteger tracks;
@property (nonatomic, assign) NSInteger tracksCounts;
@property (nonatomic, assign) NSInteger uid;

//@property (nonatomic, retain) UIImage *imageData;

@end
