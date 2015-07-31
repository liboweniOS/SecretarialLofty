//
//  AsyNetWorkTools.h
//  UIDay17_1网络请求的封装
//
//  Created by 张永涛 on 15/5/14.
//  Copyright (c) 2015年 张永涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AsyNetWorkToolDelegate <NSObject>

@optional
/**
 协议传值的方法，将需要传的值当做协议的参数
 
 */
- (void)asyResult:(id)result;

@end
//当前类为委托方，给其他类提供数据服务
@interface AsyNetWorkTools : NSObject<NSURLConnectionDataDelegate>

@property (weak,nonatomic) id<AsyNetWorkToolDelegate> delegate;

//@property (strong,nonatomic)NSDictionary *dic;//无用的传值

#pragma -mark 根据一个URL字符串创建一个异步请求类的对象
- (id)initWithString:(NSString *)urlStr;

@end
