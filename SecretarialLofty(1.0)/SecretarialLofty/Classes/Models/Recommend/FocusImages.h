//
//  FocusImages.h
//  SecretarialLofty
//
//  Created by SecretarialLofty on 15/7/9.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FocusImages : NSObject

@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, copy) NSString *shortTitle;
@property (nonatomic, copy) NSString *longTitle;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger specialId;
@property (nonatomic, assign) NSInteger subType;
@property (nonatomic, assign) BOOL isShare;
@property (nonatomic, assign) BOOL is_External_url;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, assign) NSInteger trackId;

@end
