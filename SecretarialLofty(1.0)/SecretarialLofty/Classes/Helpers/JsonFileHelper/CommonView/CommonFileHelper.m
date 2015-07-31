//
//  CommonFileHelper.m
//  SecretarialLofty
//
//  Created by SecretarialLofty on 15/7/9.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "CommonFileHelper.h"
#import "Album.h"


#define kCommonFileURL @"http://mobile.ximalaya.com/mobile/others/ca/album/track/%@/true/%ld/20?device=android&pageSize=20&albumId=%@&isAsc=true"

@interface CommonFileHelper ()

@property (nonatomic, retain) NSMutableArray *tracks;

@end

@implementation CommonFileHelper

#pragma mark - 单例构造器
+ (CommonFileHelper *)sharedCommonFileHelper
{
    static CommonFileHelper *sharedCommonFileHelper = nil;
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        
        sharedCommonFileHelper = [[CommonFileHelper alloc] init];
        
    });
    
    return sharedCommonFileHelper;
}

#pragma mark - 读取URL请求分析数据
- (void)readerCommonFileWithAlbum:(NSString *)albumId
                        pageCount:(NSInteger)pageCount
                          success:(void(^) (id obj, NSArray *tracks)) setValue
{
    // 管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    
         NSString *url = [NSString stringWithFormat:kCommonFileURL, albumId, (long)pageCount, albumId];
        
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
            // 解析数据
            NSString *jsonData = operation.responseString;
            
            NSData *data = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
            // 获取字典
            NSDictionary *allDataDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            Album *album = [Album new];
            // 将取得到得模型转换成Album类型
            [album setValuesForKeysWithDictionary:allDataDict[@"album"]];
            
            if (!self.tracks || pageCount == 1) {
                self.tracks = [NSMutableArray array];
            }

                // 循环track字典
                for (NSDictionary *trackDict in allDataDict[@"tracks"][@"list"]) {
                    Track *track = [Track new];
                    [track setValuesForKeysWithDictionary:trackDict];
                    [_tracks addObject:track];
                }
                
                setValue(album, _tracks);


            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error : %@", error);
        }];
    
    

}

@end
