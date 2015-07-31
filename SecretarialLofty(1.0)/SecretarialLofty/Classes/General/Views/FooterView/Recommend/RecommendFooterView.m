//
//  RecommendFooterView.m
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/10.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "RecommendFooterView.h"

@implementation RecommendFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addAllViews];
    }
    return self;
}

#pragma mark - 自定义方法
#pragma mark addAllViews
- (void)addAllViews
{
    self.backgroundView = [[UIImageView alloc] initWithImage:[RecommendFooterView imageWithColor:[UIColor colorWithRed:1.000 green:0.786 blue:0.641 alpha:1.000] size:CGSizeMake(511, 58) alpha:0.4]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar_category.png"]];
    
    imageView.frame = CGRectMake(0, 0, 35, 35);
    
    self.footerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _footerButton.frame = CGRectMake(imageView.frame.size.width + imageView.frame.origin.x, 0, 100, 35);
    [_footerButton setTitle:@"查看所有分类" forState:UIControlStateNormal];
    _footerButton.layer.cornerRadius = 5;
    
    [self addSubview:imageView];
    [self addSubview:_footerButton];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size alpha:(float)alpha
{
    @autoreleasepool {
        
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        UIGraphicsBeginImageContext(rect.size);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetAlpha(context, alpha);
        CGContextSetFillColorWithColor(context,color.CGColor);
        CGContextFillRect(context, rect);
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        
        
        return img;
        
    }
}

@end
