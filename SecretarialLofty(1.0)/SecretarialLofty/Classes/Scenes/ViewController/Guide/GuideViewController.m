//
//  GuideViewController.m
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/23.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "GuideViewController.h"
#import "RootTabBarViewController.h"


@interface GuideViewController ()<UIScrollViewDelegate>

@property(strong,nonatomic)UIScrollView *scrollView;
@property(strong,nonatomic)UIImageView *imageView;
@property(strong,nonatomic)UIPageControl *pageControl;

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutScrollView];
    [self layoutImageView];
    [self layoutPageControl];
}


#pragma -mark对滚动视图的布局
-(void)layoutScrollView
{
    self.scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor=[UIColor whiteColor];
    self.scrollView.contentSize=CGSizeMake(self.view.bounds.size.width*4, 0);
    self.scrollView.pagingEnabled=YES;//整屏滑动
    self.scrollView.showsHorizontalScrollIndicator=NO;//滑动条不出现
    self.scrollView.bounces=NO;//是否回弹
    self.scrollView.delegate=self;
}

#pragma -mark设置滑动图片
-(void)layoutImageView
{
    for (int i=0; i<4; i++)
    {
        self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*i, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        self.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"ydt%d.png",i+1]];
        if (i==3)
        {
            self.imageView.userInteractionEnabled=YES;
            CGSize size=[UIScreen mainScreen].bounds.size;
            UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake((size.width-100)/2, size.height-160, 100, 30)];
            button.layer.cornerRadius=8;
            [button setTitle:@"体验一下吧" forState:UIControlStateNormal];
            button.tintColor=[UIColor blackColor];
            button.layer.borderWidth=2.0f;
            button.layer.borderColor=[UIColor lightGrayColor].CGColor;
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [self.imageView addSubview:button];
            
            [button addTarget:self action:@selector(doButton) forControlEvents:UIControlEventTouchDown];
            
        }
        [self.scrollView addSubview:self.imageView];
    }
}

#pragma -mark设置分页控制器
-(void)layoutPageControl
{
    self.pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake((self.view.bounds.size.width-220)/2, self.view.bounds.size.height-50, 220, 30)];
    [self.view addSubview:self.pageControl];
    self.pageControl.numberOfPages=4;
    self.pageControl.currentPageIndicatorTintColor=[UIColor lightGrayColor];
    self.pageControl.pageIndicatorTintColor=[UIColor colorWithRed:1.000 green:0.642 blue:0.558 alpha:1.000];
    [self.pageControl addTarget:self action:@selector(pageControlAction:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)pageControlAction:(UIPageControl *)sender
{
    CGPoint x = CGPointMake(sender.currentPage * self.scrollView.frame.size.width, 0);
    
    [self.scrollView setContentOffset:x animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage=(int)(self.scrollView.contentOffset.x/self.view.bounds.size.width);
}

-(void)doButton
{
    UIWindow *window=(UIWindow *)[self.view superview];
    
    RootTabBarViewController *root=[[RootTabBarViewController alloc]init];
    window.rootViewController=root;
    
    [self.view removeFromSuperview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
