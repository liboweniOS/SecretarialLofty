//
//  CategoriesModel.h
//  SecretarialLofty
//
//  Created by 康辰 on 15/7/10.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoriesModel : NSObject

@property (nonatomic, copy) NSString *contentType;
@property (nonatomic, copy) NSString *coverPath;
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, assign) NSInteger isChecked;
@property (nonatomic, assign) NSInteger isFinished;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger orderNum;
@property (nonatomic, assign) NSInteger selectedSwitch;
@property (nonatomic, copy) NSString *title;

@end


















