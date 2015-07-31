//
//  AboutUsViewController.m
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "AboutUsViewController.h"


#define US @"文书轩是一款关于阅读类的应用，这款应用集推荐、分类和专题为一体，拥有次拥有，你可以随意的听你想听的小说、书籍、相声等娱乐，给不想看书的懒虫们带来了方便，让您随时随地都可以听书！我来读书，你来听！感谢您对文书轩的支持，我们会继续努力！"
@interface AboutUsViewController ()<UIScrollViewDelegate>


@property(nonatomic,strong)UIScrollView *scrollView;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关于我们";
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_01.png"]];
    
    [self layoutView];
    
}


#pragma mark-布局view
-(void)layoutView
{
    //导航栏左按钮
    UIImage *selectedImage=[UIImage imageNamed:@"left"];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithImage:selectedImage style:UIBarButtonItemStylePlain target:self action:@selector(doBack)];
    self.navigationItem.leftBarButtonItem=leftItem;
    
    //设置scrollview
    self.scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize=CGSizeMake(0, self.view.bounds.size.height-64);
    self.scrollView.showsVerticalScrollIndicator=YES;
    self.scrollView.pagingEnabled=YES;
    self.scrollView.delegate=self;
    
    
    //图标
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake((self.scrollView.bounds.size.width-80)/2, 30, 80, 80)];
    UIImage *image=[UIImage imageNamed:@"iconn"];
    imageView.image=image;
    imageView.layer.cornerRadius=18;
    imageView.layer.masksToBounds=YES;

    [self.scrollView addSubview:imageView];
    
    //版本号
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake((self.scrollView.bounds.size.width-100)/2, 120, 100, 20)];
    NSString* thisVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString*)kCFBundleVersionKey];//获取版本号
    label3.text=[NSString stringWithFormat:@"版本号 %@",thisVersion];
    label3.textAlignment=NSTextAlignmentCenter;
    label3.font=[UIFont systemFontOfSize:13];
    //label3.backgroundColor=[UIColor greenColor];
    [self.scrollView addSubview:label3];
    
    //关于我们
    UILabel *aboutLabel=[[UILabel alloc]initWithFrame:CGRectMake(40, 170, self.scrollView.bounds.size.width-80, 200)];
    //aboutLabel.backgroundColor=[UIColor orangeColor];
    aboutLabel.text=US;
    aboutLabel.numberOfLines=0;//可多行显示
    aboutLabel.lineBreakMode=NSLineBreakByWordWrapping;//换行
    aboutLabel.font=[UIFont systemFontOfSize:14];//设置字体大小
    [self.scrollView addSubview:aboutLabel];
    
    //版权
    UILabel *label5=[[UILabel alloc]initWithFrame:CGRectMake((self.view.bounds.size.width-240)/2, self.scrollView.bounds.size.height-104, 240, 20)];
    label5.text=@"Copyright © 2015 KLY.All Rights Reserved.";
    //label5.textColor=[UIColor grayColor];
    label5.textAlignment=NSTextAlignmentCenter;
    label5.font=[UIFont systemFontOfSize:11];
    [self.scrollView addSubview:label5];
    
   // self.edgesForExtendedLayout=UIRectEdgeNone;
}



-(void)doBack
{
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
