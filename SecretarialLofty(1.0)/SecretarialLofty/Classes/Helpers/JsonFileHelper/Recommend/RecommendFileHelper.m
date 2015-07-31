//
//  RecommendFileHelper.m
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "RecommendFileHelper.h"
#import "Recommend_Editer.h"
#import "FocusImages.h"


#define kRecommendFileURL @"http://mobile.ximalaya.com/mobile/discovery/v1/recommends?channel=and-a1&device=android&includeActivity=true&includeSpecial=true&scale=2&version=4.1.1.1"

#define kGetTrackId(trackId) [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/track/detail?device=android&trackId=%ld", trackId]

@interface RecommendFileHelper()


@end

@implementation RecommendFileHelper

#pragma mark - 单例构造器
+ (RecommendFileHelper *)sharedRecommendFileHelper
{
    static RecommendFileHelper *sharedRecommendFileHelper = nil;
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
       
        sharedRecommendFileHelper = [[RecommendFileHelper alloc] init];
        
    });
    
    return sharedRecommendFileHelper;
}

#pragma mark - 读取URL请求分析数据
- (void)readerRecommendFile:(void(^) (id obj)) setValue;
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    // 创建数组保存小编推荐信息
    NSMutableArray *editerArray = [NSMutableArray array];
    // 创建数组保存焦点图信息
    NSMutableArray *focusIamgesArray = [NSMutableArray array];
    
    // 管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
        // 请求
        [manager GET:kRecommendFileURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSString *jsonData = operation.responseString;
            
            NSData *data = [jsonData dataUsingEncoding:NSUTF8StringEncoding];

            NSDictionary *allDataDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            // 循环小编推荐信息
            for (NSDictionary *editor in allDataDict[@"editorRecommendAlbums"][@"list"]) {

                Recommend_Editer *editorObj = [[Recommend_Editer alloc] init];
                
                [editorObj setValuesForKeysWithDictionary:editor];
                
                [editerArray addObject:editorObj];
            }

            // 保存小编推荐信息
            [dict setObject:editerArray forKey:@"小编推荐"];
            
            // 循环焦点图信息
            for (NSDictionary *focusImages in allDataDict[@"focusImages"][@"list"]) {
                FocusImages *focusImagesObj = [[FocusImages alloc] init];
                [focusImagesObj setValuesForKeysWithDictionary:focusImages];
                
                [focusIamgesArray addObject:focusImagesObj];
            }
            
            // 保存焦点图信息
            [dict setObject:focusIamgesArray forKey:@"focusImages"];
            
            // 热门推荐
            for (NSDictionary *dic in allDataDict[@"hotRecommends"][@"list"]) {
                
                // 获取title值作为大字典的key
                NSString *title = dic[@"title"];
                
                // 创建可变数组，保存热门推荐对应标题（title）的元素
                NSMutableArray *hotArray = [NSMutableArray array];
                
                // 循环对应title的list
                for (NSDictionary *hotDict in dic[@"list"]) {
                    
                    Recommend_Editer *editorObj = [Recommend_Editer new];
                    
                    [editorObj setValuesForKeysWithDictionary:hotDict];
                    [editorObj setValue:dic[@"categoryId"] forKey:@"categoryId"];
                    
                    [hotArray addObject:editorObj];
                }
                
                // 保存热门信息
                [dict setObject:hotArray forKey:title];
            }
            
            setValue(dict);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error : %@", error);
        }];

}

#pragma mark - 根据TrackId获取AlbumId
- (void)readerTrackFile:(NSInteger)trackId
           albumIdBlock:(void(^) (NSString *AlbumId)) getAlbumId
{
    // 管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    [manager GET:kGetTrackId((long)trackId) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *jsonData = operation.responseString;
        
        NSData *data = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *allDataDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        getAlbumId(allDataDict[@"albumId"]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error : %@", error);
    }];
}

@end
