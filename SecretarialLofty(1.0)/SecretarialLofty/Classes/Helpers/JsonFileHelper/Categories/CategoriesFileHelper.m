//
//  CategoriesFileHelper.m
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "CategoriesFileHelper.h"
#import "CategoriesModel.h"
#import "SecondCategoriesModels.h"

@interface CategoriesFileHelper ()
@property (nonatomic, retain) NSMutableArray *allDataArray;

#define kURLStr(id, pageId) [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=%ld&device=android&pageId=%ld&pageSize=20&status=0&tagName=", id, pageId]




@end

@implementation CategoriesFileHelper

+ (CategoriesFileHelper *)sharedCategoriesFileHelper
{
    static CategoriesFileHelper *categoriesFileHelper = nil;
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        categoriesFileHelper = [[CategoriesFileHelper alloc] init];
    });
    return categoriesFileHelper;
    
}

- (void)loadDataWithURLStr:(NSString *)URLStr
                    result:(void (^)(id obj))result
{
        _allDataArray = [NSMutableArray new];
        
        __weak typeof (self)weakSelf = self;
        
        NSString *str = URLStr;
        
        NSURL *url = [NSURL URLWithString:str];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            if (!data) {
                NSLog(@"请求数据失败，请检查网络");
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"数据加载失败，请检查网络" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *array = dict[@"list"];
            for (NSDictionary *item in array) {
                CategoriesModel *m = [CategoriesModel new];
                [m setValuesForKeysWithDictionary:item];
                [weakSelf.allDataArray addObject:m];
            }
            result(_allDataArray);
        }];
}

- (void)loadDataWithCategoryId:(NSInteger)categoryId
                        pageId:(NSInteger)pageId
              completionHandle:(void(^)(id obj))completionHandle
{
        NSString *urlString = kURLStr(categoryId, pageId);
       
        __weak typeof (self)weakSelf = self;
        
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (!data) {
                NSLog(@"数据请求失败");
            }
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            if (pageId == 1) {
                weakSelf.allDataArray = [NSMutableArray array];
            }
            
            NSArray *array = dict[@"list"];
            
            for (NSDictionary *itme in array) {
                SecondCategoriesModels *m = [SecondCategoriesModels new];
                [m setValuesForKeysWithDictionary:itme];
                [weakSelf.allDataArray addObject:m];
            }
                if (completionHandle) {
                completionHandle(_allDataArray);
            }
        }];
    
}


@end









