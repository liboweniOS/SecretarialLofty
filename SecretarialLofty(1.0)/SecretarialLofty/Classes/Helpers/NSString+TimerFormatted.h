//
//  NSString+TimerFormatted.h
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TimerFormatted)

#pragma mark - 时间转换
+ (NSString *)timeFormatted:(NSInteger)totalSeconds;

@end
