//
//  AsyNetWorkTools.m
//  UIDay17_1网络请求的封装
//
//  Created by 张永涛 on 15/5/14.
//  Copyright (c) 2015年 张永涛. All rights reserved.
//

#import "AsyNetWorkTools.h"



@interface AsyNetWorkTools()
@property (strong,nonatomic)NSMutableData *reciveData;//手动延展，方便创建私有方法和属性
@property (strong,nonatomic)NSString *classification;//用来接收异步请求得到的最终数据

@end
@implementation AsyNetWorkTools

- (id)initWithString:(NSString *)urlStr
{
    if ([super init]) {
        
        //1、根据外面传递过来的字符串创建一个URL
        NSURL *url=[NSURL URLWithString:urlStr];
        //2、根据URL创建一个request请求
        NSURLRequest *requset=[NSURLRequest requestWithURL:url];
        //3、设置代理
        [NSURLConnection connectionWithRequest:requset delegate:self];
        
    }
    return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.reciveData=[[NSMutableData alloc]init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.reciveData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //拿到数据之后再让代理执行该方法，这样才会有数据
    if (self.delegate!=nil&&[self.delegate respondsToSelector:@selector(asyResult:)]) {
        [self.delegate asyResult:self.reciveData];
    }
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{

}


@end
