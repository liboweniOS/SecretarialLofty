//
//  NSString+TimerFormatted.m
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "NSString+TimerFormatted.h"

@implementation NSString (TimerFormatted)

#pragma mark - 时间转换
+ (NSString *)timeFormatted:(NSInteger)totalSeconds
{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    
    return [NSString stringWithFormat:@"%02d:%02d",minutes, seconds];
}

@end