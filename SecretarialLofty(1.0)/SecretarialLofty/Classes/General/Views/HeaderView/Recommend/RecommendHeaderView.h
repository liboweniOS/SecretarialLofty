//
//  RecommendHeaderView.h
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendHeaderView : UIView

@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) NSMutableArray *buttons;


- (instancetype)initWithFrame:(CGRect)frame andFocusImages:(NSArray *)focusImages;

@end
