//
//  CategoriesDBHelper.h
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SecondCategoriesModels;
@interface CategoriesDBHelper : NSObject

+ (instancetype)categoriesDBHepler;

- (void)insertCategories:(NSInteger)ID
                AndTitle:(NSString *)Title;

//- (void)insertCategoryModel:(SecondCategoriesModels *)Model;

- (BOOL)selectDataWithID:(NSInteger)ID;

//- (NSArray *)selectAllData:(void (^)(id obj))newResult;

- (NSArray *)selectAllData;


- (void)deleteCategoriesWith:(NSInteger)ID;

@end





