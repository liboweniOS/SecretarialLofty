//
//  CategoriesDBHelper.m
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "CategoriesDBHelper.h"
#import "FMDB.h"
#import "SecondCategoriesModels.h"

@interface CategoriesDBHelper ()

@property (nonatomic, retain) SecondCategoriesModels *secondM;

@end

@implementation CategoriesDBHelper

static FMDatabase *db = nil;
+ (instancetype)categoriesDBHepler
{
    static CategoriesDBHelper *DBHelper = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        DBHelper = [CategoriesDBHelper new];
        [DBHelper openDB];
    });
    return DBHelper;
}

- (void)openDB
{
    if (db) {
        [db open];
    } else {
   NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES).firstObject stringByAppendingString:@"DataBase.sqliet"];
    
   // NSLog(@"%@", filePath);
    
    // 创建数据库
    db = [FMDatabase databaseWithPath:filePath];
    
    // 创建数据表
    if ([db open]) {
        [db executeUpdate:@"create table if not exists wenshuxuan(albumId INTEGER, Title TEXT)"];
        NSLog(@"创建数据库");
    }
    }
}

#pragma mark 插入数据
- (void)insertCategories:(NSInteger)ID
                AndTitle:(NSString *)Title
{
    [db open];
    
  //  _secondM = [SecondCategoriesModels new];
    
    NSString *sql = [NSString stringWithFormat:@"insert into wenshuxuan(albumId, Title) values ('%ld', '%@')", (long)ID, Title];
 
    if ([db executeUpdate:sql]) {
        NSLog(@"插入成功");
    }
    [db close];
}

//- (NSArray *)selectAllData:(void (^)(id obj))newResult
//{
//    NSMutableArray *array = [NSMutableArray array];
//    
//    [db open];
//    
//    FMResultSet *set = [db executeQuery:@"select * from wenshuxuan"];
//    
//    while ([set next]) {
//        SecondCategoriesModels *secondM = [SecondCategoriesModels new];
//        
//        secondM.albumId = [set intForColumn:@"albumId"];
//        secondM.Title = [set stringForColumn:@"Title"];
//        
//        [array addObject:secondM];
//    }
//    
//    [set close];
//    [db close];
//    
//    newResult(array);
//    
//    return array;
//}

- (NSArray *)selectAllData
{
    NSMutableArray *array = [NSMutableArray array];

    [db open];

    FMResultSet *set = [db executeQuery:@"select * from wenshuxuan"];

    while ([set next]) {
        SecondCategoriesModels *secondM = [SecondCategoriesModels new];
        
        secondM.albumId = [set intForColumn:@"albumId"];
        secondM.Title = [set stringForColumn:@"Title"];
        NSLog(@"shujuku .test%@", secondM.Title);
        [array addObject:secondM];
    }

    [set close];
    [db close];

    return array;
}

- (BOOL)selectDataWithID:(NSInteger)ID
{
    BOOL result = YES;
    
    [db open];
    
    NSString *sql = [NSString stringWithFormat:@"select * from wenshuxuan where albumId = %ld", (long)ID];
    
    NSLog(@"%@", sql);
    
    FMResultSet *set = [db executeQuery:sql];
     
    if ([set next]) {
        result = YES;
    } else {
        result = NO;
    }
    
    [set close];
    [db close];

    
    return result;
}


- (void)deleteCategoriesWith:(NSInteger)ID
{
    [db open];
    
    NSString *sql = [NSString stringWithFormat:@"delete from wenshuxuan where albumId = %ld", (long)ID];
    if ([db executeUpdate:sql]) {
        NSLog(@"删除成功");
    }
    
    [db close];
    
}


@end













