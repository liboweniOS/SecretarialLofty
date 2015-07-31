//
//  RecommendHeaderView.m
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "RecommendHeaderView.h"
#import "UIButton+WebCache.h"
#import "FocusImages.h"

@implementation RecommendHeaderView

- (instancetype)initWithFrame:(CGRect)frame andFocusImages:(NSArray *)focusImages
{
    if (self = [super initWithFrame:frame]) {
        [self addAllViewsAndFocusImages:focusImages];
    }
    return self;
}

#pragma mark - 自定义方法
#pragma mark addAllViews
- (void)addAllViewsAndFocusImages:(NSArray *)focusImages
{
    
    // 初始化scrollView对象
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height)];
    [self addSubview:_scrollView];
    
    // 初始化小点点
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(20, kScreenSize.height-40, kScreenSize.width, 35)];
    _pageControl.numberOfPages = focusImages.count;
    _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:1.000 green:0.642 blue:0.558 alpha:1.000];
    _pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
    [self addSubview:_pageControl];
    
    self.buttons = [NSMutableArray array];
    
    // 设置相片缩略图
    for (int i = 0; i < focusImages.count; i++) {
        FocusImages *focusObj = focusImages[i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        // 设置tag
        button.tag = i;
        
        [button sd_setBackgroundImageWithURL:[NSURL URLWithString:focusObj.pic] forState:UIControlStateNormal];
        
        button.frame = CGRectMake(i * kScreenSize.width, 0, kScreenSize.width, kScreenSize.height );
        [_scrollView addSubview:button];
        [_buttons addObject:button];
    }
    _scrollView.contentSize = CGSizeMake(focusImages.count * kScreenSize.width, kScreenSize.height - 50);
    _scrollView.contentOffset = CGPointMake(0, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    
}

@end