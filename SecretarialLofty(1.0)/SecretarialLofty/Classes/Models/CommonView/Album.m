//
//  Album.m
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/10.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "Album.h"

@implementation Album

#pragma mark - 重写
- (void)setIntroRich:(NSString *)introRich
{
    if (_introRich != introRich) {
        _introRich = nil;
        _introRich = [introRich copy];
        
        // 将html标签替换掉

    }
}



@end