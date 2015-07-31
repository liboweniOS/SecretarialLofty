//
//  CategoriesFileHelper.h
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoriesFileHelper : NSObject

+ (CategoriesFileHelper *)sharedCategoriesFileHelper;

- (void)loadDataWithURLStr:(NSString *)URLStr
                    result:(void (^)(id obj))result;

- (void)loadDataWithCategoryId:(NSInteger)categoryId
                        pageId:(NSInteger)pageId
              completionHandle:(void(^)(id obj))completionHandle;

@end
