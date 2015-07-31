//
//  DisclaimerViewController.m
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "DisclaimerViewController.h"

#define TEXT @"本App所有节目均为免费收听，从未、也不会向用户收取任何费用。本App提供的视听节目属于出处或原作者所有，本App不对视听节目负责。\n本App做为一个网络平台，不存在商业目的，不提供任何原创视听节目，所有内容均来自互联网，以通过交流与分享，达到传递与分享的目的，因此本App所链接内容仅供网友了解与借鉴，无意侵害原作者版权；未完整注明作者或出处的链接，并非不尊重作者或者链接来源。\n本App制作方一贯高度重视知识产权保护并遵守中国各项知识产权法律、法规和具有约束力的规范性文件，重视正版，打击盗版。根据法律、法规和规范性文件要求，制定了旨在保护知识产权利人（以下统称“权利人”）发现在本App生成的链接所指向的第三方的内容侵犯其信息网络传播权时，权利人应事先向本制作方发出“权利通知”，本制作方将根据中国法律法规和政府规范性文件采取措施断开相关链接。\n任何个人或单位如果同时符合以下两个条件：\n1.是某一作品的著作权人和、或依法可以行使信息网络传播权的权利人；\n2.本App链接到第三方的内容侵犯了上述作品的信息网络传播权。\n请上述个人或单位对版权有任何争议，请E-MAIL至Tracy_young529@sina.com,本App制作者确认后将充分尊重您的意见，我们会在24小时内给予答复，立即更正或删除。"
@interface DisclaimerViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UILabel *TDisclaimerLabel;
@property(nonatomic,strong)UILabel *SDisclaimerLabel;
@property(nonatomic,strong)UIScrollView *scrollView;

@end

@implementation DisclaimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_01.png"]];
    
    [self layoutView];
}


-(void)layoutView
{
    //导航栏左按钮
    UIImage *selectedImage=[UIImage imageNamed:@"left"];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithImage:selectedImage style:UIBarButtonItemStylePlain target:self action:@selector(doBack)];
    self.navigationItem.leftBarButtonItem=leftItem;
    
    //设置scrollview
    self.scrollView=[[UIScrollView alloc]initWithFrame:kScreenNewSize];
    [self.view addSubview:_scrollView];
    self.scrollView.contentSize=CGSizeMake(0, self.view.frame.size.height);
    self.scrollView.showsVerticalScrollIndicator=YES;
    self.scrollView.pagingEnabled=YES;
    self.scrollView.delegate=self;
    
    //题目
    self.TDisclaimerLabel=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, 30, 100, 30)];
    // self.TDisclaimerLabel.backgroundColor=[UIColor orangeColor];
    self.TDisclaimerLabel.text=@"免责声明";
    self.TDisclaimerLabel.textAlignment=NSTextAlignmentCenter;//居中
    [self.scrollView addSubview:self.TDisclaimerLabel];
    
    //内容
    self.SDisclaimerLabel=[[UILabel alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(_TDisclaimerLabel.frame) - 10, (self.view.bounds.size.width-80), self.view.frame.size.height - 100)];
    // self.SDisclaimerLabel.backgroundColor=[UIColor grayColor];
    self.SDisclaimerLabel.text=TEXT;
    self.SDisclaimerLabel.numberOfLines=0;//可多行显示
    self.SDisclaimerLabel.lineBreakMode=NSLineBreakByWordWrapping;//换行
    self.SDisclaimerLabel.font=[UIFont systemFontOfSize:14];//设置字体大小
    [self.scrollView addSubview:self.SDisclaimerLabel];
    
//    _SDisclaimerLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    [_SDisclaimerLabel addConstraint:[NSLayoutConstraint constraintWithItem:_SDisclaimerLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:<#(CGFloat)#>]];
//    
    
}


-(void)doBack
{
    [self.navigationController popViewControllerAnimated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
