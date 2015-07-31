//
//  CommonFileHelper.h
//  SecretarialLofty
//
//  Created by SecretarialLofty on 15/7/9.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonFileHelper : NSObject

#pragma mark - 单例构造器
+ (CommonFileHelper *)sharedCommonFileHelper;

#pragma mark - 读取URL请求分析数据
- (void)readerCommonFileWithAlbum:(NSString *)albumId
                             pageCount:(NSInteger)pageCount
                          success:(void(^) (id obj, NSArray *tracks)) setValue;

@end
