//
//  RecommendFileHelper.h
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RecommendFileHelper : NSObject

#pragma mark - 单例构造器
+ (RecommendFileHelper *)sharedRecommendFileHelper;

#pragma mark - 读取URL请求分析数据
- (void)readerRecommendFile:(void(^) (id obj)) setValue;

#pragma mark - 根据TrackId获取AlbumId
- (void)readerTrackFile:(NSInteger)trackId
           albumIdBlock:(void(^) (NSString *AlbumId)) getAlbumId;

@end
